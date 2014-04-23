class AutomessagesController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    Automessage.send_automated_message(params)
    redirect_to root_url
  end

  private

  def message_params
    params.permit[:to, :from]
  end



end
