require 'rails_helper'

RSpec.feature 'Unfollowing Friends' do
  before do
    @sohel = User.create!(email: 'sohel@test.com', first_name: 'sohel', last_name: 'anon', password: '123456')
    @john = User.create!(email: 'john@test.com', first_name: 'john', last_name: 'daby', password: '123456')

    login_as(@sohel)

    @following = Friendship.create(user: @sohel, friend: @john)
  end

  scenario do
    visit '/'

    click_link 'My Lounge'
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content(@john.full_name + ' unfollowed')
  end
end