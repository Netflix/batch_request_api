Rails.application.routes.draw do
  scope :api do
    namespace :v1, defaults: {format: 'json'} do
      resources :batch_sequential
      resources :batch_parallel
    end
  end
end
