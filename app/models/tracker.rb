class Tracker < ApplicationRecord
  #validates :notes, allow_blank: true, allow_nil: true
  belongs_to :user
  belongs_to :habit
end
