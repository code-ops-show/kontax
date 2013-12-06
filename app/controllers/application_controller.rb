class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Transponder::Transmission

  before_filter :set_gon_pusher

  def set_gon_pusher
    gon.pusher  = { key: ENV['PUSHER_KEY'] }
  end
end
