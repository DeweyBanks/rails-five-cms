require 'rails_helper'

RSpec.feature "User visits admin dashboard/admins page" do
  scenario "They are a super admin" do
    user = FactoryBot.create(:user, super_admin: true)
    login_as(user, :scope => :user)
    visit admin_users_path
    expect(page.current_path).to eq(admin_users_path)
    expect(page).to have_content "Admins"
  end

  scenario "They are a not super admin" do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit admin_users_path
    expect(page.current_path).to eq(admin_dashboard_path)
    expect(page).to have_content "Insufficient rights!"
  end
end
