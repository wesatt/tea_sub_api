class Tea < ApplicationRecord
  has_many(:subscriptions)
  has_many(:customers, through: :subscriptions)

  validates_presence_of(:title)
  validates_presence_of(:description)
  validates_numericality_of(:temperature) # in fahrenheit
  validates_numericality_of(:brew_time) # in seconds
end
