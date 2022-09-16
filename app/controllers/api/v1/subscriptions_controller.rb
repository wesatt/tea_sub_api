class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      error_handler(subscription.errors.messages, :bad_request)
    end
  end

  def destroy
    subscription = Subscription.find_by(customer_id: params[:customer_id], id: params[:id])
    if subscription&.cancelled!
      render json: SubscriptionSerializer.new(subscription), status: :accepted
    else
      error_handler({:'Customer id' => ['and subscription id do not match']}, :bad_request)
    end
  end

  def index
    subs = current_customer.subscriptions
    render json: SubscriptionSerializer.new(subs), status: :accepted
  end

  private

  def current_customer
    c ||= Customer.find(params[:customer_id])
  end

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end
