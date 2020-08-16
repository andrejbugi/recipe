module UsersHelper
  def log_in(user)
    visit login_path

    within('form') do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_on 'Sign In'
    end
  end

  def request_log_in(user)
    get '/login'

    post_params = {
      params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
    }
    post '/login', post_params
  end
end
