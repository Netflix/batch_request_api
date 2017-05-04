``` ruby
  class SampleParallelController < ApplicationController
    def update
      to_render = nil
      if params['_json'].present?
        responses = SampleParallel.bulk_update(record_hashes) # here is where you update in a rails transaction
        to_render = {
          json: responses.as_json
        }
      elsif @sample_parallel.update(sample_parallel_params)
        to_render = {
          json: @work_item
        }
      else
        to_render = {
          json: serializable_errors(@ample_parallel),
          status: :unprocessable_entity
        }
      end
      render to_render
    end
  end
```
