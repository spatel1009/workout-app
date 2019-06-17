class Exercise < ApplicationRecord
  belongs_to :user

  validates :duration_in_min, presence: true
  validates :workout, presence: true
  validates :workout_date, presence: true

  scope :all_user_exer, ->(user) { where('exercises.user_id >= ?', user)}
  default_scope { order(created_at: :desc) }
end
