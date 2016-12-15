class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :error
  #before_action :authenticate_user!#, :except => [:index]
  private

	#def current_user
	  #@current_user ||= User.find_by(id: session[:user_id])
	 # @current_user ||= User.find(session[:user_id]) if session[:user_id]

	#end

	helper_method :current_user, :user_signed_in?, :user_session
end
