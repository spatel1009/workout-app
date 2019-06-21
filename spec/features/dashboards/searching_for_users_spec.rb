require 'rails_helper'

RSpec.feature 'Searching for Users' do
  before do
    @sohel = User.create!(email: 'sohel@test.com', first_name: 'sohel', last_name: 'anon', password: '123456')
    @john = User.create!(email: 'john@test.com', first_name: 'john', last_name: 'daby', password: '123456')
  end

  scenario 'with existing name returns all those users' do
    visit '/'

    fill_in 'search_name', with: 'anon'
    click_button 'Search'

    expect(page).to have_content(@sohel.full_name)
    expect(current_path).to eq('/dashboards/search')
  end
end