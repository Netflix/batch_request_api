module BatchRequestApi
  module BatchUtil
    def get_payload(env)
      request = Rack::Request.new(env.deep_dup)
      payload = JSON.parse(request.body.read)
      payload['requests']
    end

    def build_response(responses)
      [200, { 'Content-Type' => 'application/json' }, [{ responses: responses }.to_json]]
    end

    def setup_env(env, item, json_body)
      env['PATH_INFO'] = item['url']
      env['REQUEST_METHOD'] = item['method']
      env['rack.input'] = StringIO.new(json_body)
    end
  end
end
