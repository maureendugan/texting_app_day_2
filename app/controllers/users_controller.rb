class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @contacts = current_user.contacts
    @user = User.find(params[:id])
    @message = Message.new
    @contact = Contact.new
  end
end
