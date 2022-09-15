class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.format_subscription(subscription), status: :created
    else
      error_handler(subscription.errors.messages, :bad_request)
    end
  end

  def destroy
    subscription = Subscription.find_by(customer_id: params[:customer_id], id: params[:id])
    if subscription&.cancelled!
      render json: SubscriptionSerializer.format_subscription(subscription), status: :accepted
    else
      error_handler({:'Customer id' => ['and subscription id do not match']}, :bad_request)
    end
  end

  private

  # def current_tea
  #   t ||= Tea.find(params[:tea_id])
  # end

  # def current_customer
  #   u ||= Customer.find(params[:customer_id])
  # end

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end
