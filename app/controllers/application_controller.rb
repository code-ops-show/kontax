class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Transponder::Transmission

  before_filter :set_gon_pusher

  before_action :set_fake_session

  def set_gon_pusher
    gon.pusher  = { key: ENV['PUSHER_KEY'] }
  end

  # in a real app you can use current_user.id or session or something
  def set_fake_session
    session[:who] ||= SecureRandom.hex(6)
    gon.who = session[:who]
  end
end
