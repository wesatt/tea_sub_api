require 'rails_helper'

RSpec.describe '/api/v1/customers/:id/subscriptions requests', type: :request do
  let!(:customer1) { Customer.create!(first_name: 'Patrick', last_name: 'Stewart', email: 'ohcaptain@tealover.com', address: '1234 Love Tea Dr, Spilled Tea, TX 12345') }
  let!(:customer2) { Customer.create!(first_name: 'Mister', last_name: 'Tea', email: 'piteathefool@tealover.com', address: '4321 Love Tea Dr, Spilled Tea, TX 12345') }
  let!(:tea1) { Tea.create!(title: 'Glengettie', description: "Mae'r cyfuniad o flas arbennig ac ansawdd wedi gwneud Glengettie yn ffefryn yng Nghymru ers blynyddoedd lawer.", temperature: 190, brew_time: 300) }
  let!(:tea2) { Tea.create!(title: 'Chai', description: 'Black tea with a mixture of aromatic herbs and spices.', temperature: 200, brew_time: 240) }
  let!(:tea3) { Tea.create!(title: 'Earl Grey', description: 'Tea. Earl grey. Hot.', temperature: 200, brew_time: 240) }
  let!(:tea4) { Tea.create!(title: 'Peppermint', description: 'Great for your tummy troubles', temperature: 208, brew_time: 300) }
  before(:each) do
    Subscription.create!(title: "Captain's Choice", price: 1000, status: 0, frequency: 4, customer: customer1, tea: tea3)
    Subscription.create!(title: 'Single Tea', price: 1000, status: 1, frequency: 2, customer: customer1, tea: tea4)
    Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 2, customer: customer2, tea: tea3)
    Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 4, customer: customer2, tea: tea1)
    Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 6, customer: customer2, tea: tea2)
  end

  describe 'subscribe a customer to a tea subscription' do
    describe 'happy path' do
      it 'Can subscribe a customer to a new tea subscription' do
        expect(customer1.subscriptions.count).to eq(2)
        creation_params = ({tea_id: tea1.id})
        post "/api/v1/customers/#{customer1.id}/subscriptions", params: creation_params

        expect(response).to be_successful
        expect(customer1.subscriptions.count).to eq(3)
      end
    end
  end
end
