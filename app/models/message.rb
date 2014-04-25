require 'active_model'
require 'rest_client'
require 'json'

class Message
  include ActiveModel::Model

  class_attribute :twilio_sid, :twilio_token

  attr_accessor :from, :to, :body

  def deliver
    response = RestClient::Request.new(
      method: :post,
      url: "https://api.twilio.com/2010-04-01/Accounts/#{twilio_sid}/Messages.json",
      user: twilio_sid,
      password: twilio_token,
      payload: {
        Body: body,
        To: to,
        From: from
      }
    ).execute
  rescue RestClient::BadRequest => error
    message = JSON.parse(error.response)['message']
    errors.add :base, message
    false
  end
end

