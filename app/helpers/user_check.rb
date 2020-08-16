module UserCheck
  def check_current_user(user)
    unless same_as_current_user?(user)
      flash[:danger] = 'Wrong User'
      redirect_to root_path
    end
  end
end
