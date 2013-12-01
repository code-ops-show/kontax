class ContactsController < ApplicationController
  respond_to :json, :html, :js

  def index
    @contacts = Contact.all
    respond_with @contacts
  end

  def new
    @contact = Contact.new
  end

  def edit
    @contact = Contact.where(id: params[:id]).first
  end
end