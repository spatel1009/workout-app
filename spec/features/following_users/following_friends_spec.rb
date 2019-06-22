require 'rails_helper'

RSpec.feature 'Following Friends' do
  before do
    @sohel = User.create!(email: 'sohel@test.com', first_name: 'sohel', last_name: 'anon', password: '123456')
    @john = User.create!(email: 'john@test.com', first_name: 'john', last_name: 'daby', password: '123456')
    login_as(@sohel)
  end

  scenario 'if signed in' do
    visit '/'

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sohel.full_name)

    href = "/friendships?friend_id=#{@sohel.id}"
    expect(page).not_to have_link("Follow", href: href)

    link = "a[href='/friendships?friend_id=#{@john.id}']"
    find(link).click

    href = "/friendships?friend_id=#{@john.id}"
    expect(page).not_to have_link("Follow", href: href)
  end
end