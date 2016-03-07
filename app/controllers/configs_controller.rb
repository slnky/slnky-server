class ConfigsController < ApplicationController
  def index
    # ?
  end

  def show
    name = params['id']
    config = {
        rabbit: secrets['rabbit'], # services always need to know rabbit config
        common: secrets['common'], # shared config
    }
    config[name] = secrets[name] if secrets[name]
    render json: config
  end

  protected

  def secrets
    Rails.application.secrets
  end
end
