class Habit < ApplicationRecord
  has_many :habit_entries, dependent: :destroy
end
