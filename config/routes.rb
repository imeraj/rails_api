Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def api_version(version, &routes)
    api_constraints = APIConstraints.new(version: version)
    scope module: "api/v#{version}", constraints: api_constraints, defaults: { format: :json }, &routes
  end

  api_version(1) do

  end

  api_version(2) do

  end

end
