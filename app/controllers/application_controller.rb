# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    before_action :require_login, except: [:new, :create, :home]
  
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    helper_method :current_user
  
    def require_login
      redirect_to root_path unless current_user
    end
end
  