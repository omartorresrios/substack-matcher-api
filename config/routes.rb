Rails.application.routes.draw do
  namespace :api do
    post 'validate_url', to: 'url_validator#validate'
  end
end