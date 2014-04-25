$LOAD_PATH << 'app/models'
require 'message'
require 'webmock/rspec'

describe Message do
  its(:errors) { should be_empty }

  its(:from) { should be_nil }
  its(:to) { should be_nil }
  its(:body) { should be_nil }

  describe '#deliver' do
    before do
      Message.stub twilio_sid: 'sid'
      Message.stub twilio_token: 'abcdef'
    end

    it 'sends a text message via the twilio API and returns true' do
      request = WebMock.stub_request(:post,
        'https://sid:abcdef@api.twilio.com/2010-04-01/Accounts/sid/Messages.json'
      ).with(
        body: {
          From: '8675309',
          To: '911',
          Body: 'omgwtfbbq'
        }
      )

      message = Message.new(from: '8675309', to: '911', body: 'omgwtfbbq')
      response = message.deliver

      response.should be_true
      request.should have_been_requested
    end

    it 'is false when the API returns an error and sticks the error in errors' do
      request = WebMock.stub_request(:post,
        'https://sid:abcdef@api.twilio.com/2010-04-01/Accounts/sid/Messages.json'
      ).to_return(
        status: 400,
        body: '{"message": "you are a jerk"}'
      )

      message = Message.new(from: 'notanumber', to: ':)', body: nil)
      response = message.deliver

      response.should be_false
      message.errors.full_messages.should == ["you are a jerk"]
    end
  end
end

