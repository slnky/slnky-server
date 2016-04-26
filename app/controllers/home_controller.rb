class HomeController < ApplicationController
  def index
    @heartbeats = Slnky.brain.hgetall(:heartbeat)
  end
end
