class Habit < ApplicationRecord
  belongs_to :user
  has_many :trackers, dependent: :destroy
end
