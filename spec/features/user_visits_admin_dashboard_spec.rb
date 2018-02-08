require 'rails_helper'

RSpec.feature "User visits admin dashboard" do
  scenario "They visit the dashboard without logging in" do
    visit admin_path
    expect(page.current_path).to eq(new_user_session_path)
    expect(page).to have_content "Unauthorized: You need to sign in before continuing."
  end

  scenario "They visit the dashboard after logging in" do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit admin_path
    expect(page.current_path).to eq(admin_path)
    expect(page).to have_content "welcome: admin@ehe.com"
  end
end