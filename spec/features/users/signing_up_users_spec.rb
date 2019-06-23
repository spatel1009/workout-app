require 'rails_helper'

RSpec.feature 'Registering a User' do
  before do
    visit '/'
    click_link 'Sign up'
  end

  scenario 'with valid credentials' do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'First name', with: 'testing'
    fill_in 'Last name', with: 'anonymous'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_button 'Sign up'

    expect(page).to have_content('You have signed up successfully')
    expect(page.current_path).to eq(root_path)

    user = User.last
    room = user.room
    room_name = user.full_name.split.join('-')

    expect(room.name).to eq(room_name)
  end

  scenario 'with invalid credentials' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end

end