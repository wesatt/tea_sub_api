require 'rails_helper'

RSpec.describe '/api/v1/customers/:id/subscriptions requests', type: :request do
  let!(:customer1) { Customer.create!(first_name: 'Patrick', last_name: 'Stewart', email: 'ohcaptain@tealover.com', address: '1234 Love Tea Dr, Spilled Tea, TX 12345') }
  let!(:customer2) { Customer.create!(first_name: 'Mister', last_name: 'Tea', email: 'piteathefool@tealover.com', address: '4321 Love Tea Dr, Spilled Tea, TX 12345') }
  let!(:tea1) { Tea.create!(title: 'Glengettie', description: "Mae'r cyfuniad o flas arbennig ac ansawdd wedi gwneud Glengettie yn ffefryn yng Nghymru ers blynyddoedd lawer.", temperature: 190, brew_time: 300) }
  let!(:tea2) { Tea.create!(title: 'Chai', description: 'Black tea with a mixture of aromatic herbs and spices.', temperature: 200, brew_time: 240) }
  let!(:tea3) { Tea.create!(title: 'Earl Grey', description: 'Tea. Earl grey. Hot.', temperature: 200, brew_time: 240) }
  let!(:tea4) { Tea.create!(title: 'Peppermint', description: 'Great for your tummy troubles', temperature: 208, brew_time: 300) }
  let!(:subscription1) { Subscription.create!(title: "Captain's Choice", price: 1000, status: 0, frequency: 4, customer: customer1, tea: tea3) }
  let!(:subscription2) { Subscription.create!(title: 'Single Tea', price: 1000, status: 1, frequency: 2, customer: customer1, tea: tea4) }
  let!(:subscription3) { Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 2, customer: customer2, tea: tea3) }
  let!(:subscription4) { Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 4, customer: customer2, tea: tea1) }
  let!(:subscription5) { Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 6, customer: customer2, tea: tea2) }

  describe 'subscribe a customer to a tea subscription' do
    describe 'happy path' do
      it 'Can subscribe a customer to a new tea subscription' do
        expect(customer1.subscriptions.count).to eq(2)
        creation_params = {
          title: 'Fall Tea Collection',
          price: '1000',
          frequency: 4,
          tea_id: tea1.id
        }
        post "/api/v1/customers/#{customer1.id}/subscriptions", params: creation_params

        expect(response).to be_successful
        expect(customer1.subscriptions.count).to eq(3)
        response_hash = json[:data]
        expect(response_hash.keys).to include(:id, :type, :attributes)
        expect(response_hash.keys.count).to eq(3)
        attributes = response_hash[:attributes]
        expect(attributes.keys).to include(
          :title, :price, :status, :frequency, :customer_id, :tea_id
        )
        expect(attributes.keys.count).to eq(6)
        expect(attributes[:title]).to eq('Fall Tea Collection')
        expect(attributes[:price]).to eq(1000)
        expect(attributes[:status]).to eq('active')
        expect(attributes[:frequency]).to eq(4)
        expect(attributes[:customer_id]).to eq(customer1.id)
        expect(attributes[:tea_id]).to eq(tea1.id)
      end
    end

    describe 'sad path' do
      it 'will return an error if necessary information is missing' do
        expect(customer1.subscriptions.count).to eq(2)
        creation_params = {
          title: 'Fall Tea Collection',
          price: '1000',
          frequency: 4
        }
        post "/api/v1/customers/#{customer1.id}/subscriptions", params: creation_params

        expect(response).to_not be_successful
        expect(customer1.subscriptions.count).to eq(2)
        response_hash = json[:data]
        expect(response_hash.keys).to include(:id, :type, :message)
        expect(response_hash.keys.count).to eq(3)
        expect(response_hash[:id]).to eq(nil)
        expect(response_hash[:type]).to eq('error')
        expect(response_hash[:message]).to eq('Tea must exist')
      end
    end
  end

  describe 'cancel a tea subscription' do
    describe 'happy path' do
      it "Can cancel a customer's tea subscription" do
        expect(customer2.subscriptions.active.count).to eq(3)
        expect(customer2.subscriptions.cancelled.count).to eq(0)
        delete "/api/v1/customers/#{customer2.id}/subscriptions/#{subscription4.id}"

        expect(response).to be_successful
        expect(customer2.subscriptions.active.count).to eq(2)
        expect(customer2.subscriptions.cancelled.count).to eq(1)
        response_hash = json[:data]
        expect(response_hash.keys).to include(:id, :type, :attributes)
        expect(response_hash.keys.count).to eq(3)
        attributes = response_hash[:attributes]
        expect(attributes.keys).to include(
          :title, :price, :status, :frequency, :customer_id, :tea_id
        )
        expect(attributes.keys.count).to eq(6)
        expect(attributes[:title]).to eq('Fall Tea Collection')
        expect(attributes[:price]).to eq(1000)
        expect(attributes[:status]).to eq('cancelled')
        expect(attributes[:frequency]).to eq(4)
        expect(attributes[:customer_id]).to eq(customer2.id)
        expect(attributes[:tea_id]).to eq(tea1.id)
      end
    end

    describe 'sad path' do
      it 'will return an error if customer and subscription ids do not match' do
        expect(customer2.subscriptions.active.count).to eq(3)
        expect(customer2.subscriptions.cancelled.count).to eq(0)
        delete "/api/v1/customers/#{customer2.id}/subscriptions/#{subscription1.id}"


        expect(response).to_not be_successful
        expect(customer2.subscriptions.active.count).to eq(3)
        expect(customer2.subscriptions.cancelled.count).to eq(0)
        response_hash = json[:data]
        expect(response_hash.keys).to include(:id, :type, :message)
        expect(response_hash.keys.count).to eq(3)
        expect(response_hash[:id]).to eq(nil)
        expect(response_hash[:type]).to eq('error')
        expect(response_hash[:message]).to eq('Customer id and subscription id do not match')
      end
    end
  end

  describe "display all of a customer's tea subscriptions" do
    describe 'happy path' do
      it "Can display all of a customer's tea subscriptions" do
        get "/api/v1/customers/#{customer1.id}/subscriptions/"

        expect(response).to be_successful
        response = json[:data]
        expect(response).to be_a(Array)
        expect(response.count).to eq(2)
        expect(response[0][:attributes][:status]).to eq('active')
        expect(response[1][:attributes][:status]).to eq('cancelled')
        response.each do |response_hash|
          expect(response_hash.keys).to include(:id, :type, :attributes)
          expect(response_hash.keys.count).to eq(3)
          attributes = response_hash[:attributes]
          expect(attributes.keys).to include(
            :title, :price, :status, :frequency, :customer_id, :tea_id
          )
          expect(attributes.keys.count).to eq(6)
          expect(attributes[:title]).to be_a(String)
          expect(attributes[:price]).to be_a(Integer)
          expect(attributes[:status]).to eq('cancelled').or eq('active')
          expect(attributes[:frequency]).to be_a(Integer)
          expect(attributes[:customer_id]).to be_a(Integer)
          expect(attributes[:tea_id]).to be_a(Integer)
        end
      end
    end

    describe 'sad path' do
      it 'will return an error if ...' do
        expect(customer2.subscriptions.active.count).to eq(3)
        expect(customer2.subscriptions.cancelled.count).to eq(0)
        delete "/api/v1/customers/#{customer2.id}/subscriptions/#{subscription1.id}"


        expect(response).to_not be_successful
        expect(customer2.subscriptions.active.count).to eq(3)
        expect(customer2.subscriptions.cancelled.count).to eq(0)
        response_hash = json[:data]
        expect(response_hash.keys).to include(:id, :type, :message)
        expect(response_hash.keys.count).to eq(3)
        expect(response_hash[:id]).to eq(nil)
        expect(response_hash[:type]).to eq('error')
        expect(response_hash[:message]).to eq('Customer id and subscription id do not match')
      end
    end
  end
end
