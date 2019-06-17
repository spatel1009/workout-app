require 'rails_helper'

RSpec.feature 'Sign users out' do
  before do
    @testing = User.create!(email: 'test@test.com', first_name: 'test', last_name: 'anon', password: '123456')
  end
  scenario 'user successfully signs out' do
    login_as(@testing)
    visit '/'
    click_link 'Sign out'

    expect(page).to have_content("Signed out successfully")
    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
    expect(page).not_to have_link('Sign out')
    expect(page.current_path).to eq(root_path)
  end
end