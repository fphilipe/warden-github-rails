Example::Application.routes.draw do
  github_authenticate do
    get '/orgs' => 'organizations#index', :as => :orgs
    get '/profile' => 'users#show', :as => :profile
  end

  github_authenticate(:team => lambda { |req| req.params[:id] }) do
    get '/teams/:id' => 'teams#show', :as => :team
  end

  github_authenticate(:org => lambda { |req| req.params[:id] }) do
    get '/orgs/:id' => 'organizations#show', :as => :org
  end

  get '/login'  => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  resources :users

  root :to => 'home#show'

  match '*all' => 'application#not_found'
end
