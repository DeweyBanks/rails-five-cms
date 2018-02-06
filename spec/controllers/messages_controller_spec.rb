require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) {
        {'message' => {
          'first_name' => 'John',
          'last_name' => 'Smith',
          'company_name' => 'Test Company',
          'email' => 'jsmith@example.com',
          'interest' => 'Test Interest',
          'comment' => 'Test Comment'
          }
        }
      }

      it 'creates a new Message' do
        expect {
          post :create, params: valid_params
        }.to change(Message, :count).by(1)
      end

      it "sends an email to the moderators" do
        valid_message = double(save: true)
        allow(Message).to receive(:new).and_return(valid_message)
        allow(MessageMailer).to receive(:notification_email)
        post :create, params: valid_params
        expect(MessageMailer).to have_received(:notification_email).with(valid_message)
      end
    end

    context "without valid params" do
      let(:invalid_params) {
        {'message' => {
          'first_name' => '',
          'last_name' => '',
          'company_name' => '',
          'email' => '',
          'interest' => '',
          'comment' => ''
          }
        }
      }

      it 'creates a new Message' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Message, :count)
      end

      it "sends an email to the moderators" do
        valid_message = double(save: true)
        allow(Message).to receive(:new).and_return(valid_message)
        allow(MessageMailer).to receive(:notification_email)
        post :create, params: invalid_params
        expect(MessageMailer).to have_received(:notification_email).with(valid_message)
      end


    end

  end
end

