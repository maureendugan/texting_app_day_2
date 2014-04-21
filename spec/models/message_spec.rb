require 'spec_helper'

describe Message, vcr: true do

  it { should belong_to :user }

  it 'adds an error if the to number is invalid' do
    message = Message.new(body: 'hi', to: '1111111', from: '9718017923')
    message.save
    message.errors.messages[:base].should eq ["The 'To' number 1111111 is not a valid phone number."]
  end
end
