class MessagesController < ApplicationController
  def create
    message = Message.new(params[:message])
    if message.deliver
      flash.notice = "Success"
    else
      flash.alert = message.errors.to_s
    end
    redirect_to current_user
  end
end

