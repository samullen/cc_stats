Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :page_views do
      get :daily_top_urls, on: :collection
      get :daily_top_referrers, on: :collection
    end
  end
end
