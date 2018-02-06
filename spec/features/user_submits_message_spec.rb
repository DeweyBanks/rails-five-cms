require 'rails_helper'

RSpec.feature "User submits a message" do
  scenario "They visit the contact page and fill out form" do
    first_name = "John"
    last_name = "Smith"
    company_name = "John Smith Company"
    email = "JSmith@example.com"
    interest = "Offering EHE to my company"
    comment = "Test Comment"

    visit "/pages/contact"
    fill_in "First Name", with: first_name
    fill_in "Last Name", with: last_name
    fill_in "Company Name", with: company_name
    fill_in "message[email]", with: email
    fill_in "Comment", with: comment
    click_on "Create Message"
    expect { click_on "Create Message" }.to change(Message, :count).by(1)
    expect(page.current_path).to eq("/pages/contact")
    expect(page).to have_content "Thank you for your interest!"
  end

  scenario "They visit the Corporate Partnership page and fill out form" do
    first_name = "John"
    last_name = "Smith"
    company_name = "John Smith Company"
    email = "JSmith@example.com"
    interest = "Offering EHE to my company"
    comment = "Test Comment"

    visit "/pages/corporate_partnership"
    fill_in "First Name", with: first_name
    fill_in "Last Name", with: last_name
    fill_in "Company Name", with: company_name
    fill_in "message[email]", with: email
    fill_in "Comment", with: comment
    click_on "Create Message"
    expect { click_on "Create Message" }.to change(Message, :count).by(1)
    expect(page.current_path).to eq("/pages/corporate_partnership")
    expect(page).to have_content "Thank you for your interest!"
  end
end

