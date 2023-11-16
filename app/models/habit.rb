class Habit < ApplicationRecord
  belongs_to :user
  has_many :trackers
end
