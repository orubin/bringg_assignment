module URISigner

  extend self

  ACCESS_TOKEN = ENV['ACCESS_TOKEN']
  SECRET_KEY = ENV['SECRET_KEY']

  def sign(params)
    params[:timestamp] ||= Time.now.to_i
    params[:access_token] ||= ACCESS_TOKEN
    query_params = params.to_query
    params.merge(signature: OpenSSL::HMAC.hexdigest('sha1', SECRET_KEY, query_params))
    params
  end

end
