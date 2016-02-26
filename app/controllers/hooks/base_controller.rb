class Hooks::BaseController < ActionController::Base
  protected

  def publish(exchange, message)
    Services::Publisher.publish(exchange, message)
  end
end
