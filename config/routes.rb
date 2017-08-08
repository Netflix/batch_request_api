Rails.application.routes.draw do
  BatchRequestApi.config.batch_sequential_paths.each do |path|
    post path, constraints: { format: :json }
  end

  BatchRequestApi.config.batch_parallel_paths.each do |path|
    post path, constraints: { format: :json }
  end
end
