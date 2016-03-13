class ConfigsController < ApplicationController
  def index
    # ?
  end

  def show
    name = params['id']
    config = secrets['common']
    config['rabbit'] = secrets['rabbit']
    config[name] = secrets[name] if secrets[name]
    render json: config
  end

  protected

  def secrets
    Rails.application.secrets
  end
end
