class ContactsController < ApplicationController
  respond_to :json, :html, :js

  def index
    @contacts = scoped_contacts
    respond_with @contacts
  end

  def new
    @contact = Contact.new
    cased_response
  end

  def show
    @contact = Contact.where(id: params[:id]).first
    cased_response(params[:notify])
  end

  def create 
    @contact = Contact.new(contact_params)
    if @contact.save
      cased_response
      push_notify
    else
      xms_error @contact
    end
  end

  def edit
    @contact = Contact.where(id: params[:id]).first
    cased_response
  end

  def update
    @contact = Contact.where(id: params[:id]).first
    if @contact.update_attributes(contact_params)
      cased_response(params[:case])
      push_notify
    else
      xms_error @contact
    end
  end

  def destroy
    @contact = Contact.where(id: params[:id]).first
    if @contact.move_to_trash
      cased_response
      push_notify
    else
      xms_error @contact
    end
  end

private

  def cased_response(cased_param = nil)
    # :case and :notify will always come at different times
    if cased_param.present? 
      render cased_param
    else
      respond_with @contact
    end
  end

  def base_notify_data
    { resource: 'contacts', id: @contact.id, who: session[:who], case: params[:case] }
  end

  def index_notify_data
    base_notify_data.merge({ action: action_name })
  end

  def trashed_notify_data
    _action_name = 
      if action_name == 'update' and params[:case].present? and params[:case] == 'untrashed'
        'destroy'
      elsif action_name == 'update' and params[:case].present? and params[:case] == 'trashed'
        'create'
      end
    base_notify_data.merge({ action: _action_name })
  end

  def push_notify
    push_index
    push_trashed
  end

  def push_index
    Pusher.trigger_async("contacts", "index", index_notify_data)
  end

  def push_trashed
    Pusher.trigger_async("contacts", "trashed", trashed_notify_data)
  end

  def contacts_event
    params[:case].present? ? "trashed" : "index"
  end

  helper_method :contacts_event

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