class Exercise < ApplicationRecord
  belongs_to :user

  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout, presence: true
  validates :workout_date, presence: true

  scope :all_user_exer, ->(user) { where('exercises.user_id >= ?', user)}
  default_scope { where('workout_date > ?', 7.days.ago)
                  .order(created_at: :desc) }
end
