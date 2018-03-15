require 'batch_request_api/batch_parallel'

describe BatchRequestApi::BatchParallel do
  let(:my_klass) { Class.new.extend(described_class) }
  let(:env) { double('env') }
  let(:first_request) { double('request').as_null_object }
  let(:requests) { [first_request] }

  before do
    allow(my_klass).to receive(:set_id_on_record_for_patch)
    allow(my_klass).to receive(:process_parallel_request)
    allow(my_klass).to receive(:build_response)
    allow(my_klass).to receive(:get_payload).and_return(requests)
  end

  describe "#batch_parallel" do
    it "fetches requests from payload" do
      expect(my_klass).to receive(:get_payload).and_return([double('request').as_null_object])
      my_klass.batch_parallel(env)
    end

    context 'when the first request is PATCH' do
      it 'sets id on record for patch' do
        requests = [{'method' => 'PATCH'}]
        allow(my_klass).to receive(:get_payload).and_return(requests)
        expect(my_klass).to receive(:set_id_on_record_for_patch).once
        my_klass.batch_parallel(env)
      end
    end

    context 'when the first request is not PATCH' do
      it 'does not set id on record for patch' do
        requests = [{'method' => 'GET'}]
        allow(my_klass).to receive(:get_payload).and_return(requests)
        expect(my_klass).not_to receive(:set_id_on_record_for_patch)
        my_klass.batch_parallel(env)
      end
    end

    it 'processes requests in parallel' do
      expect(my_klass).to receive(:process_parallel_request).with(env, first_request, requests)
      my_klass.batch_parallel(env)
    end

    it 'builds a response from all the responses' do
      responses = double('responses')
      allow(my_klass).to receive(:process_parallel_request).and_return(responses)
      expect(my_klass).to receive(:build_response).with(responses)
      my_klass.batch_parallel(env)
    end
  end
end
