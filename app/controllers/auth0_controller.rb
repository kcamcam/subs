class Auth0Controller < ApplicationController
  skip_before_action :set_current_user

  def callback
    # This stores all the user information that came from Auth0 and the IdP
    session[:userinfo] = request.env['omniauth.auth']
    userinfo = session[:userinfo].deep_symbolize_keys
    user_hash = {
      uid: userinfo[:uid],
      name: userinfo.dig(:info, :name),
      nickname: userinfo.dig(:info, :nickname),
      given_name: userinfo.dig(:extra, :raw_info, :given_name),
      family_name: userinfo.dig(:extra, :raw_info, :family_name),
      locale: userinfo.dig(:extra, :raw_info, :locale),
      email: userinfo.dig(:info, :email),
      image: userinfo.dig(:info, :image),
    }
    User.where(uid: userinfo[:uid]).first_or_create.update(user_hash)
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
