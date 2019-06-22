require 'rails_helper'

RSpec.feature 'Followign Friends' do
  before do
    @sohel = User.create!(email: 'sohel@test.com', first_name: 'sohel', last_name: 'anon', password: '123456')
    @john = User.create!(email: 'john@test.com', first_name: 'john', last_name: 'daby', password: '123456')

    @ex1 = @john.exercises.create!(duration_in_min: 55, workout: 'testing workout', workout_date: Date.today)

    login_as(@sohel)

    @following = Friendship.create(user: @sohel, friend: @john)
  end

  scenario "shows friend's workout for last 7 days" do
    visit '/'

    click_link "My Lounge"
    click_link @john.full_name

    expect(page).to have_content(@john.full_name + "'s Exercises")
    expect(page).to have_content(@ex1.workout)
    expect(page).to have_css("div#chart")
  end
end