class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :register_events
    respond_to :json

    include Authenticable
    include EventSubscriber
end
