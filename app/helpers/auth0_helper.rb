module Auth0Helper
  private

  # Set the @current_user or redirect to public page
  def authenticate_user!
    if user_signed_in?
      @current_user = session[:userinfo]&.deep_symbolize_keys
    else
      redirect_to root_path
    end
  end

  # Is the user signed in?
  # @return [Boolean]
  def user_signed_in?
    session[:userinfo].present?
  end

  # Who is the current_user?
  # @return [Hash]
  def current_user
    @current_user
  end

  def logout_url
    domain = Rails.application.credentials[:auth0_domain]
    client_id = Rails.application.credentials[:auth0_client_id]
    request_params = { returnTo: root_url, client_id: client_id }
    URI::HTTPS.build(host: domain, path: '/v2/logout', query: to_query(request_params))
  end

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{CGI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end
end
