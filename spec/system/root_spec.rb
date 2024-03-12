require 'rails_helper'

describe 'Root' do
  it 'shows the home page' do
    visit '/'
    expect(page).to have_content('Hello, Root Page!')
    find('input[data-hello-target="name"]').set('Capybara')
    click_link_or_button('Greet')
    expect(page).to have_content('Hello, Capybara!')
  end
end
