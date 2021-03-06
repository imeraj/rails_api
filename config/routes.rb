require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def api_version(version, default, &routes)
    api_constraints = APIConstraints.new(version: version, default: default)
    scope module: "api/v#{version}", constraints: api_constraints, defaults: { format: :json }, &routes
  end

  api_version(1, true) do
    post    '/signup',     to: 'users#create'

    post    '/login',      to: 'sessions#create'
    delete  '/logout',     to: 'sessions#destroy'

    resources :users, :only => [:show, :index, :update, :destroy] do
        resources :orders, :only => [:index, :show, :create]
    end
    resources :products, :only => [:show, :index, :create, :update, :destroy]
  end

  api_version(2, false) do
  end
end
