class ConfigsController < ApplicationController
  before_filter :set_cache_headers

  def index
    # ?
  end

  def show
    name = params['id']
    config = secrets['common'].dup
    config[name] = secrets[name] if secrets[name]
    render json: config
  end

  protected

  def secrets
    Rails.application.secrets
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
