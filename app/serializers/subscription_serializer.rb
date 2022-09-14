class SubscriptionSerializer
  def self.format_subscription(data)
    {
      data: {
        id: data.id,
        type: 'subscription',
        attributes: {
          title: data.title,
          price: data.price,
          status: data.status,
          frequency: data.frequency,
          customer_id: data.customer_id,
          tea_id: data.tea_id
        }
      }
    }
  end
end
