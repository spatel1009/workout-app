require 'rails_helper'

RSpec.feature 'Listing Exercises' do
  before do
    @sohel = User.create!(email: 'test@test.com', first_name: 'test', last_name: 'anon', password: '123456')
    login_as(@sohel)

    @ex1 = Exercise.create!(user_id: @sohel.id, duration_in_min: 55, workout: 'testing workout', workout_date: Date.today)
    @ex2 = Exercise.create!(user_id: @sohel.id, duration_in_min: 65, workout: 'testing workout 2', workout_date: 2.days.ago)
    @ex3 = Exercise.create!(user_id: @sohel.id, duration_in_min: 85, workout: 'testing workout 3', workout_date: 20.days.ago)

  end
  
  scenario 'show users workouts for last 7 days' do
    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content(@ex1.workout)
    expect(page).to have_content(@ex1.workout_date)
 
    expect(page).to have_content(@ex2.workout)
    expect(page).to have_content(@ex2.workout_date)

    expect(page).not_to have_content(@ex3.workout)
    expect(page).not_to have_content(@ex3.workout_date)
  end

  scenario 'shows no exercises if none created' do
    @sohel.exercises.delete_all

    visit '/'
    click_link 'My Lounge'

    expect(page).to have_link('New Workout')
    expect(page).to have_content('No Exercises Created')
  end
end