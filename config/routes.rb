Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Manually buiding this route as we need this `constraint` to allow dots (.) in the URI.  Not sure how to include constraints through ActiveAdmin directly.
  get "/admin/contributions/:id/contributer" => "admin/contributions#contributer", :constraints => {:id => /[^\/]+/}

  root to: "admin/dashboard#index"
end
