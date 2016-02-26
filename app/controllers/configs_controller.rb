class ConfigsController < ApplicationController
  def index
    # ?
  end

  def show
    name = params['id']
    secrets = Rails.application.secrets
    config = {
        rabbit: secrets.rabbit,
    }
    config[name] = secrets.send(name) if secrets.send(name)
    render json: config
  end
end