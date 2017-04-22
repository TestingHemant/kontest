class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActionController::UnknownController, :with => :record_not_found
  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_to_referer_or_path
  rescue_from ActionController::StatementInvalid, :with => :ISE
  #rescue_from ActiveRecord::PendingMigrationError, :with => :migration_pending

  protect_from_forgery with: :exception
  add_flash_types :error
  #before_action :authenticate_user!#, :except => [:index]
  private

  def record_not_found
    render "pages/404"
  end

  def ISE
    render "pages/502"
  end
  
  def migration_pending
    flash[:notice] = "Site under heavy load, please try after sometime."
    redirect_to "/"
  end

  def redirect_to_referer_or_path
    flash[:notice] = "Not authorised to access this page."
    redirect_to request.referer
  end

	#def current_user
	  #@current_user ||= User.find_by(id: session[:user_id])
	 # @current_user ||= User.find(session[:user_id]) if session[:user_id]

	#end

	helper_method :current_user, :user_signed_in?, :user_session
end
