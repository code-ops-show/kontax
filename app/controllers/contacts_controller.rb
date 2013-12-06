class ContactsController < ApplicationController
  respond_to :json, :html, :js

  def index
    @contacts = scoped_contacts
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
      cased_response
    else
      xms_error @contact
    end
  end

  def destroy
    @contact = Contact.where(id: params[:id]).first
    if @contact.move_to_trash
      respond_with @contact
    else
      xms_error @contact
    end
  end

private
  def cased_response
    if params[:case].present?
      render params[:case]
    else
      respond_with @contact
    end
  end

  def scoped_contacts
    if params[:case].present? and params[:case] == 'trashed'
      Contact.trashed.search(params[:query])
    else
      Contact.not_trashed.search(params[:query])
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :trash)
  end
end