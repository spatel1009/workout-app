require 'rails_helper'

RSpec.feature 'Listing Exercises' do
  before do
    @sohel = User.create!(email: 'sohel@test.com', first_name: 'sohel', last_name: 'anon', password: '123456')
    @john = User.create!(email: 'john@test.com', first_name: 'john', last_name: 'daby', password: '123456')
    login_as(@sohel)

    @following = Friendship.create(user: @sohel, friend: @john)

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

  scenario "shows a list of user's friends" do
    visit '/'

    click_link('My Lounge')

    expect(page).to have_content("Friends following:")
    expect(page).to have_link(@john.full_name)
    expect(page).to have_link("Unfollow")
  end
end