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
    if current_user.contacts.create(contact_params)
      redirect_to user_path(current_user), notice: 'Contact saved.'
    else
      render 'new'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to contacts_path, notice: 'Contact updated.'
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone_number)
  end
end
