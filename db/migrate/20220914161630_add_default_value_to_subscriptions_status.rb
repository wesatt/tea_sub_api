class AddDefaultValueToSubscriptionsStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :subscriptions, :status, :integer, :default => 0
  end
end
