class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    array_to = params[:message][:to].select { |to| to != "" }
    count = 0
    errors = []
    array_to.each do |to|
      new_message = Message.new(strong)
      new_message[:to] = to
      if new_message.save
        count += 1
      else
        errors << new_message.errors.first
      end
    end
    if array_to.length == count && count != 0
      redirect_to user_path(current_user), :flash => { :notice => "Success" }
    elsif array_to.length == 0
      redirect_to user_path(current_user), :flash => { :error => "Please select a contact" }
    else
      redirect_to user_path(current_user), :flash => { :error => errors.first }
    end
  end

  def show
    @message = Message.find(params[:id])
  end

private

  def strong
    params.require(:message).permit(:to, :from, :body)
  end

end
