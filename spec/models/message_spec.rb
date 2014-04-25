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
      Message.twilio_sid = 'sid'
      Message.twilio_token = 'abcdef'
    end

    it 'sends a text message via the twilio API' do
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
      message.deliver

      request.should have_been_requested
    end
  end
end

# describe Message, vcr: true do
# 
#   it { should belong_to :user }
# 
#   it 'adds an error if the to number is invalid' do
#     message = Message.new(body: 'hi', to: '1111111', from: '9718017923')
#     message.save
#     message.errors.messages[:base].should eq ['The 'To' number 1111111 is not a valid phone number.']
#   end
# end
