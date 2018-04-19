require "batch_request_api/batch_util"

module BatchRequestApi
  module BatchSequential
    include BatchUtil

    def batch_sequential(env)
      requests = get_payload(env)
      @fail_fast = env['HTTP_FAIL_FAST']
      begin
        responses = requests.map do |item|
          process_request(env.deep_dup, item)
        end
        build_response(response_hash(responses))
      rescue StandardError => ex
        responses = [] if responses.nil?
        responses << ex.message
        return build_response(response_hash(responses))
      end
    end

    private

      def process_request(env, item)
        json_body = item['body'].to_json
        setup_env(env, item, json_body)
        handoff_to_rails(env)
      end

      def handoff_to_rails(env)
        status, headers, body = @app.call(env)
        body.close if body.respond_to? :close
        if status > 399 && @fail_fast
          raise StandardError, { status: status, headers: headers, response: JSON.parse(body.first) }
        end
        { status: status, headers: headers, response: JSON.parse(body.first) }
      end

      def response_hash(responses)
        { status: 200, headers: { 'Content-Type' => 'application/json' }, response: responses }
      end
  end
end
