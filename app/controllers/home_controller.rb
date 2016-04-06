class HomeController < ApplicationController
  def index
    @heartbeats = Heartbeats.instance.report
  end
end
