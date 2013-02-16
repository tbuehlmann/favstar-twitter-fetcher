FavstarTwitterFetcher::Application.routes.draw do
  resources :tweets, :only => [:index, :create]
  root :to => 'tweets#index'
end
