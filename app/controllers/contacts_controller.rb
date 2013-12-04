class ContactsController < ApplicationController
  respond_to :json, :html, :js

  def index
    @contacts = Contact.all
    respond_with @contacts
  end

  def new
    @contact = Contact.new
    respond_with @contact
  end

  def create 
    @contact = Contact.new(contact_params)
    if @contact.save
      respond_with @contact
    else
      xms_error @contact
    end
  end

  def edit
    @contact = Contact.where(id: params[:id]).first
    respond_with @contact
  end

  def update
    @contact = Contact.where(id: params[:id]).first
    if @contact.update_attributes(contact_params)
      respond_with @contact
    else
      xms_error @contact
    end
  end

private
  def contact_params
    params.require(:contact).permit(:name, :email)
  end
end