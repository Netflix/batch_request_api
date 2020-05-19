Rails.application.routes.draw do
  not_found_response = ->(env) { [404, {}, []] }

  BatchRequestApi.config.batch_sequential_paths.each do |batch_sequential_path|
    post batch_sequential_path, constraints: { format: :json }, to: not_found_response
  end

  BatchRequestApi.config.batch_parallel_paths.each do |batch_parallel_path|
    post batch_parallel_path, constraints: { format: :json }, to: not_found_response
  end
end
