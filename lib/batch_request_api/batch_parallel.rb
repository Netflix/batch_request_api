require "batch_request_api/batch_util"

module BatchRequestApi
  module BatchParallel
    include BatchUtil

    def batch_parallel(env)
      requests = get_payload(env)
      first_request = requests.first
      # Post and Delete methods do not need any processing
      set_id_on_record_for_patch(requests) if first_request['method'] == 'PATCH'
      responses = process_parallel_request(env, first_request, requests)
      build_response(responses)
    end

    private

      def process_parallel_request(env, first_request, requests)
        json_body = requests.map { |item| item['body'] }.to_json
        setup_env(env, first_request, json_body)
        handoff_to_rails(env)
      end

      def set_id_on_record_for_patch(requests)
        ids = requests.map { |request| request['url'].match(%r((?<=\/)\d+$|(?<=\/)(\d+)(?=\.json$))).to_s }
        requests.each_with_index do |request, index|
          request['body']['data']['attributes']['id'] = ids[index] # dependency on json api spec
        end
        requests
      end
  end
end
