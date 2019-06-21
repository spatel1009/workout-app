require 'rails_helper'

RSpec.feature 'Listing Members' do
  before do
    @sohel = User.create!(email: 'sohel@test.com', first_name: 'sohel', last_name: 'anon', password: '123456')
    @john = User.create!(email: 'john@test.com', first_name: 'john', last_name: 'daby', password: '123456')
  end

  scenario 'shows a list of registered members' do
    visit '/'

    expect(page).to have_content('List of Members')
    expect(page).to have_content(@sohel.full_name)
    expect(page).to have_content(@john.full_name)
  end
end