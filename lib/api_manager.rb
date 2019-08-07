require 'uri_signer'

module APIManager

  extend self

  BASE_API = 'https://api.bringg.com/partner_api'
  CUSTOMERS_API = '/customers'
  TASKS_API = '/tasks'

  def create_user(params)
    signed_params = URISigner.sign(params)
    res = post_api_call(signed_params, CUSTOMERS_API)
    error_handler(res) if res && (res['success'] == false || res.code != 200)
    res
  end

  def create_task(params)
    signed_params = URISigner.sign(params)
    res = post_api_call(signed_params, TASKS_API)
    error_handler(res) if res && (res['success'] == false || res.code != 200)
    res
  end

  def get_tasks(params)
    signed_params = URISigner.sign(params)
    res = get_api_call(signed_params, TASKS_API)
    error_handler(res) if res && (res['success'] == false || res.code != 200)
    res
  end

  private

  def post_api_call(signed_params, action)
    uri = URI(BASE_API + action)
    req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
    req.body = signed_params.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
    end
    res.body if res.is_a?(Net::HTTPSuccess)
  end

  def patch_api_call(signed_params, action)
    # implementation
  end

  def get_api_call(signed_params, action)
    uri = URI(BASE_API + action)
    req = Net::HTTP.get(uri)
    res.body if res.is_a?(Net::HTTPSuccess)
  end

  def error_handler()
  end

end
