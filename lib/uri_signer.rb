module URISigner

  extend self

  ACCESS_TOKEN = 'ZtWsDxzfTTkGnnsjp8yC'
  SECRET_KEY = 'V_-es-3JD82YyiNdzot7'

  def sign(params)
    # params = {"customer_id" => 174, "title" => "this is just a test"}
    params[:timestamp] ||= Time.now.to_i
    params[:access_token] ||= ACCESS_TOKEN
    query_params = params.to_query
    params.merge(signature: OpenSSL::HMAC.hexdigest('sha1', SECRET_KEY, query_params))
    params
  end

end
