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

  def show
    @contact = Contact.where(id: params[:id]).first
    notification_response
  end

  def create 
    @contact = Contact.new(contact_params)
    if @contact.save
      respond_with @contact
      push_notify
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
      push_notify
    else
      xms_error @contact
    end
  end

  def destroy
    @contact = Contact.where(id: params[:id]).first
    if @contact.move_to_trash
      respond_with @contact
      push_notify
    else
      xms_error @contact
    end
  end

private

  def notification_response
    if params[:notify].present? 
      render params[:notify]
    else
      respond_with @contact
    end
  end

  def notify_data
    { resource: 'contacts', id: @contact.id, action: action_name, who: session[:who] }
  end

  def push_notify
    Pusher.trigger_async("contacts", "index", notify_data)
  end

  def contacts_event
    params[:scope].present? ? params[:scope] : "index"
  end

  helper_method :contacts_event

  def scoped_contacts
    if params[:scope].present? and params[:scope] == 'trashed'
      Contact.trashed.search(params[:query])
    else
      Contact.not_trashed.search(params[:query])
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :trash)
  end
end