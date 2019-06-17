require 'rails_helper'

RSpec.feature 'Creating Exercise' do
  before do
    @sohel = User.create!(email: 'test@test.com', first_name: 'test', last_name: 'anon', password: '123456')

    login_as(@sohel)
    visit '/'
    click_link 'My Lounge'
    click_link 'New Workout'
  end

  scenario 'with valid inputs' do
    expect(page).to have_link('Back')

    fill_in 'Duration', with:70
    fill_in 'Workout Details', with: 'Weight lifting'
    fill_in 'Activity date', with: '2016-07-26'
    click_button 'Create Exercise'

    expect(page).to have_content('Exercise has been created')
    
    exercise = Exercise.last
    expect(currenth_path).to eq(user_exercise_path(@sohel, exercise))
    expect(exercise.user_id).to eq(current_user.id)
  end

  scenario 'with invalid inputs' do

  end
end