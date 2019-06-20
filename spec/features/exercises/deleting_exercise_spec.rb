require 'rails_helper'

RSpec.feature 'Delete an exercise' do
  before do
    @sohel = User.create!(email: 'test@test.com', first_name: 'test', last_name: 'anon', password: '123456')
    @exercise = Exercise.create!(user_id: @sohel.id, duration_in_min: 55, workout: 'testing workout', workout_date: Date.today)

    login_as(@sohel)
    visit '/'
  end

  scenario 'successfully' do
    click_link('My Lounge')
    click_link('Delete exercise')

    expect(page).to have_content('Exercise successfully deleted')
    expect(current_path).to eq(user_exercises_path(@sohel))
  end
end