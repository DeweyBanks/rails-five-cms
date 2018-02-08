require 'rails_helper'
require 'faker'

RSpec.feature "User submits a message" do
  scenario "They visit the contact page and fill out form" do
    visit "/pages/contact"
    fill_in "message_first_name", with: Faker::Name.first_name
    fill_in "message_last_name", with: Faker::Name.last_name
    fill_in "message_company_name", with: Faker::Company.name
    fill_in "message_email", with: Faker::Internet.email
    fill_in "message_comment", with: Faker::Fallout.quote

    expect { click_on "Create Message" }.to change(Message, :count).by(1)
    expect(page.current_path).to eq("/pages/contact")
    expect(page).to have_content "Thank you for your interest!"
  end

  scenario "They visit the Corporate Partnership page and fill out form" do
    visit "/pages/corporate_partnership"
    fill_in "message_first_name", with: Faker::Name.first_name
    fill_in "message_last_name", with: Faker::Name.last_name
    fill_in "message_company_name", with: Faker::Company.name
    fill_in "message_email", with: Faker::Internet.email
    fill_in "message_comment", with: Faker::Fallout.quote

    expect { click_on "Create Message" }.to change(Message, :count).by(1)
    expect(page.current_path).to eq("/pages/corporate_partnership")
    expect(page).to have_content "Thank you for your interest!"
  end
end

