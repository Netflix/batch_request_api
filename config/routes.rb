Rails.application.routes.draw do
  if batch_sequential_path = BatchRequestApi.config.batch_sequential_path
    post batch_sequential_path, constraints: { format: :json }
  end

  if batch_parallel_path = BatchRequestApi.config.batch_parallel_path
    post batch_parallel_path, constraints: { format: :json }
  end
end
