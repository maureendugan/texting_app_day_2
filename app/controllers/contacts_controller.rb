class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.create(strong)
    redirect_to contacts_path
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update

  end

  def destroy

  end


  private

  def strong
    params.require(:contact).permit(:name, :phone_number, :user_id)
  end
end
