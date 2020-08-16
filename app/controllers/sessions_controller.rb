class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = 'Successfully logged in!'
      redirect_to user
    else
      flash.now[:danger] = 'Wrong email or password.'
      render :new
    end
  end

  def destroy
    log_out

    redirect_to root_path
  end
end
