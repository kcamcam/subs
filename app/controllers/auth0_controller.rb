class Auth0Controller < ApplicationController
  skip_before_action :authenticate_user!

  def callback
    # This stores all the user information that came from Auth0 and the IdP
    session[:userinfo] = request.env['omniauth.auth']
    User.first_or_create(uid: session[:userinfo][:uid])
    # Redirect to the URL you want after successful auth
    redirect_to root_path
  end

  def login
    render layout: 'login'
  end

  def logout
    reset_session
    redirect_to logout_url.to_s
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end
end
