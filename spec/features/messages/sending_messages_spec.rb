require 'rails_helper'

RSpec.feature 'Sending Messages' do
  before do
    @sohel = User.create!(email: 'sohel@test.com', first_name: 'sohel', last_name: 'anon', password: '123456')
    @john = User.create!(email: 'john@test.com', first_name: 'john', last_name: 'daby', password: '123456')
    @sam = User.create!(email: 'sam@test.com', first_name: 'sam', last_name: 'ruze', password: '123456')

    @room_name = @sohel.first_name + '-' + @sohel.last_name
    @room = Room.create!(name: @room_name, user_id: @sohel.id)

    login_as(@sohel)

    Friendship.create!(user: @john, friend: @sohel)
    Friendship.create!(user: @sam, friend: @sohel)
  end

  scenario 'to followers shows in chatroom window' do
    visit '/'

    click_link 'My Lounge'
    expect(page).to have_content(@room_name)

    fill_in 'message-field', with: 'Hello'
    click_button 'Post'

    expect(page).to have_content('Hello')

    within('#followers') do
      expect(page).to have_link(@john.full_name)
      expect(page).to have_link(@sam.full_name)
    end
  end
end