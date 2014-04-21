class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(strong)
    redirect_to user_path(current_user)
  end

  def show
    @message = Message.find(params[:id])
  end

private

  def strong
    params.require(:message).permit(:to, :from, :body)
  end

end
