class ApplicationController < ActionController::Base
  include SessionsHelper
  include UserCheck

  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:danger] = 'Please sign in to continue.'
      redirect_to login_path
    end
  end
end

