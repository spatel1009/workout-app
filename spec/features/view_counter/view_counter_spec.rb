require 'rails_helper'

RSpec.feature 'Increases view counter correctly' do
  before do
    @sohel = User.create!(email: 'test@test.com', first_name: 'test', last_name: 'anon', password: '123456')
    @exercise = Exercise.create!(user_id: @sohel.id, duration_in_min: 55, workout: 'testing workout', workout_date: Date.today)
  end

  scenario 'once page has been visited' do
    expect{visit user_exercise_path(@sohel, @exercise)}.to change{@exercise.reload.count}.by(1)
    expect(page).to have_content(@exercise.workout)
    expect(page).to have_content(@exercise.workout_date)
  end
end