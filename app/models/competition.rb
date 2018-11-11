class Competition < ApplicationRecord
  has_many :users
  has_many :stats

  # validates :calories
  # validates :miles
  # validates :steps
  # validates :start_date
  # validates :end_date
end
