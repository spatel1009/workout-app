require 'rails_helper'

RSpec.feature 'Signing in Users' do
  before do
    @testing = User.create!(email: 'test@test.com', first_name: 'test', last_name: 'anon', password: '123456')

    visit '/'
    click_link 'Sign in'
  end

  scenario 'with correct information' do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('Signed in successfully.')
    expect(page).not_to have_link('Log in')
    expect(page).not_to have_link('Sign up')
  end

  scenario 'with wrong password' do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'wrong'
    click_button 'Log in'

    expect(page.current_path).to eq(new_user_session_path)
    expect(page).to have_content('Invalid Email or password')
  end
end