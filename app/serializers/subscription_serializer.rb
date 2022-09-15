class SubscriptionSerializer
  def self.format_subscription(subscription)
    {
      data: {
        id: subscription.id,
        type: 'subscription',
        attributes: {
          title: subscription.title,
          price: subscription.price,
          status: subscription.status,
          frequency: subscription.frequency,
          customer_id: subscription.customer_id,
          tea_id: subscription.tea_id
        }
      }
    }
  end

  def self.format_subscriptions(subscriptions)
    {
      data: subscriptions.map do |s|
        {
          id: s.id,
          type: 'subscription',
          attributes: {
            title: s.title,
            price: s.price,
            status: s.status,
            frequency: s.frequency,
            customer_id: s.customer_id,
            tea_id: s.tea_id
          }
        }
      end
    }
  end
end
