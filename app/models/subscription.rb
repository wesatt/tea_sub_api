class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of(:title)
  validates_numericality_of(:price) # in US cents
  validates_presence_of(:status)
  validates_numericality_of(:frequency) # in weeks

  enum status: %i[active cancelled]
end
