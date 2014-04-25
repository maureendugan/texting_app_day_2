require "active_model"
require "rest_client"

class Message
  include ActiveModel::Model

  attr_accessor :from, :to, :body

  def deliver
    response = RestClient::Request.new(
      method: :post,
      url: "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
      user: ENV['TWILIO_ACCOUNT_SID'],
      password: ENV['TWILIO_AUTH_TOKEN'],
      payload: {
        Body: body,
        To: to,
        From: from
      }
    ).execute
  end
end

#     rescue RestClient::BadRequest => error
#       message = JSON.parse(error.response)['message']
#       errors.add(:base, message)
#       false
#     end
