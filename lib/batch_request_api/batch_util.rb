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

    def handoff_to_rails(env)
      status, headers, body = @app.call(env)
      body.close if body.respond_to? :close
      processed_body = processed_body_proxy(body)
      { status: status, headers: headers, response: JSON.parse(processed_body) }
    end
    
    def processed_body_proxy(body)
      response = nil
      if body.respond_to?(:each)
        response = body.first
      else
        response = body.body
      end
      response
    end
  end
end
