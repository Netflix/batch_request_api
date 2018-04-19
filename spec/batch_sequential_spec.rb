require 'batch_request_api/batch_sequential'
require 'json/ext'

describe BatchRequestApi::BatchSequential do
  let(:my_klass) { Class.new.extend(described_class) }
  let(:env) { {} }
  let(:first_request) { double('request').as_null_object }
  let(:requests) { [first_request, first_request] }

  before do
    allow(my_klass).to receive(:build_response).and_call_original
    allow(my_klass).to receive(:get_payload).and_return(requests)
    env.class.send(:define_method, 'deep_dup') do
      {}
    end
  end

  describe '#batch_sequential' do
    it 'fetches requests from payload' do
      expect(my_klass).to receive(:get_payload).and_return([double('request').as_null_object])
      my_klass.batch_sequential(env)
    end

    it 'builds a response from all the responses' do
      responses = {
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        response: [
          {:status=>200, :headers=>{:"Content-Type"=>"application/json"}, :response=>[{:status=>200}, {:status=>200}]},
          {:status=>200, :headers=>{:"Content-Type"=>"application/json"}, :response=>[{:status=>200}, {:status=>200}]}
        ]
      }

      allow(my_klass).to receive(:process_request).and_return(responses)
      allow(my_klass).to receive(:batch_sequential).and_call_original

      response = my_klass.batch_sequential(env)
      parsed_responses = response.last.map {|r| JSON.parse(r)}
      expect(parsed_responses.last['responses']['response'].size).to eq(2)
    end

    it 'fails fast' do
      responses = {
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        response: [ "{:status=>500, :headers=>{:\"Content-Type\"=>\"application/json\"}, :response=>\"\"}" ]
      }

      env['HTTP_FAIL_FAST'] = true
      allow(my_klass).to receive(:process_request)
                           .and_raise(StandardError.new({
                               status: 500,
                               headers: { 'Content-Type': 'application/json'},
                               response: ''
                             })
      )
      allow(my_klass).to receive(:batch_sequential).and_call_original
      expect(my_klass).to receive(:build_response).with(responses)

      response = my_klass.batch_sequential(env)

      expect(response.last.size).to eq(1)
    end
  end
end
