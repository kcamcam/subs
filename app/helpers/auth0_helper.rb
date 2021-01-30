module Auth0Helper
  private

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
