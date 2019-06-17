require 'rails_helper'

RSpec.feature 'Successfully update an exercise' do
  before do
    @sohel = User.create!(email: 'test@test.com', first_name: 'test', last_name: 'anon', password: '123456')
    @exercise = Exercise.create!(user_id: @sohel.id, duration_in_min: 55, workout: 'testing workout', workout_date: '2017-05-03')

    login_as(@sohel)
    visit '/'
  end

  scenario 'with valid input' do
    click_link 'My Lounge'
    click_link("Edit exercise")
    expect(page).to have_link('Back')
    
    fill_in 'Duration', with: 75
    click_button 'Update Exercise'

    expect(page).to have_content('Exercise has been updated')
    expect(current_path).to eq(user_exercise_path(@sohel, @exercise))
    expect(@exercise.user_id).to eq(@sohel.id)
  end
end