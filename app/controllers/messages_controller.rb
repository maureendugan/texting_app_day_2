class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(strong)
    if @message.save
      redirect_to user_path(current_user), :flash => { :notice => "Success" }
    else
      redirect_to user_path(current_user), :flash => { :error => @message.errors.messages[:base].first }
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
