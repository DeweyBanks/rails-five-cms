require "rails_helper"

RSpec.describe MessageMailer, "#new_message" do
  it "delivers a new notification email" do
    message = FactoryBot.build(:message)
    email = MessageMailer.notification_email(message)
    expect(email).to deliver_to("deweybanks@gmail.com")
    expect(email).to deliver_from("from@example.com")
    expect(email).to have_subject("Contact Message")
    expect(email).to have_body_text("#{message.comment}")
  end
end
