class Heartbeats
  class << self
    def instance
      @instance ||= self.new
    end
  end

  def initialize
    @services = {}
  end

  def handle(name)
    @services[name] = Time.now
  end

  def report
    @services
  end
end
