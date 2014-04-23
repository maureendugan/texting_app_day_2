require 'spec_helper'

describe Automessage, vcr: true do
  it 'sends a message out to a user if they send one to the master user number' do
    RestClient.post('http://localhost:3000/inboundmessages', "ToCountry"=>"US", "ToState"=>"OR", "SmsMessageSid"=>"SM33a9d6b50fc9ccbba486be05d89fbc54", "NumMedia"=>"0", "ToCity"=>"", "FromZip"=>"97296", "SmsSid"=>"SM33a9d6b50fc9ccbba486be05d89fbc54", "FromState"=>"OR", "SmsStatus"=>"received", "FromCity"=>"PORTLAND", "Body"=>"Hhft", "FromCountry"=>"US", "To"=>"+19718017923", "ToZip"=>"", "MessageSid"=>"SM33a9d6b50fc9ccbba486be05d89fbc54", "AccountSid"=>"ACb43d54e008cae0df74cb87badc9a3add", "From"=>"+15035046871", "ApiVersion"=>"2010-04-01"){|response, request, result| response }
    # binding.pry
    response = RestClient::Request.new(:method => :get, :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json", :user => ENV['TWILIO_ACCOUNT_SID'], password: ENV['TWILIO_AUTH_TOKEN']).execute
    parsed_response = JSON.parse(response)
    messages_data = parsed_response['messages']
    # binding.pry
    messages_data.first['body'].should eq "This is an unattended number"
  end
end
