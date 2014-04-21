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
    @contact = Contact.new(strong)
    if @contact.save
      flash[:notice] = 'Contact saved.'
      redirect_to contacts_path
    else
      render 'new'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(strong)
      flash[:notice] = 'Contact updated.'
      redirect_to contacts_path
    else
      render 'edit'
    end
  end

  def destroy

  end


  private

  def strong
    params.require(:contact).permit(:name, :phone_number, :user_id)
  end
end
