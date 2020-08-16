require 'rails_helper'

RSpec.describe "Users" do
  it "creates User and redirects to the User page" do
    get '/users/signup'

    post_params = {
      params: {
        user: {
          username: 'useruser',
          first_name: 'First name',
          last_name: 'Last name',
          email: 'brad@brad.com',
          password: '12341234',
          password_confirmation: '12341234'
        }
      }
    }

    post '/users', post_params

    expect(session[:user_id]).not_to be_nil

    follow_redirect!

    expect(response.body).to include('useruser')
    expect(response.body).to include('brad@brad.com')
  end

  it 'renders New when User params are empty' do
    get '/users/signup'

    post_params = {
      params: {
        user: {
          username: '',
          first_name: '',
          last_name: '',
          email: '',
          password: '',
          password_confirmation: ''
        }
      }
    }

    post '/users', post_params

    expect(session[:user_id]).to be_nil
    expect(response.body).to include('7 errors prohibited this user')
  end
end
