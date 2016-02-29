class Services::Publisher
  class << self
    def publish(exchange, message={})
      # check if EM already running, if so, we don't want to kill it later
      running = EventMachine.reactor_running?
      # http://rubyamqp.info/articles/working_with_exchanges/#toc_27
      EventMachine.run do
        @host ||= Rails.application.secrets.rabbit['host']
        @port ||= Rails.application.secrets.rabbit['port']
        connection = AMQP.connect(host: @host, port: @port)
        channel    = AMQP::Channel.new(connection)
        x = channel.fanout("slnky.#{exchange}")
        x.publish(Slnky::Message.new(message).to_s) do
          connection.close { EventMachine.stop unless running }
          # connection.close {}
        end
      end
    end

    # # From: http://codetunes.com/2014/event-sourcing-on-rails-with-rabbitmq/
    # # In order to publish message we need a exchange name.
    # # Note that RabbitMQ does not care about the payload -
    # # we will be using JSON-encoded strings
    # def publish(exchange, message = {})
    #   # grab the fanout exchange
    #   x = channel.fanout("slnky.#{exchange}")
    #   # and simply publish message
    #   x.publish(message.to_json)
    # end
    #
    # def channel
    #   @channel ||= connection.create_channel
    # end
    #
    # # We are using default settings here
    # # The `Bunny.new(...)` is a place to
    # # put any specific RabbitMQ settings
    # # like host or port
    # def connection
    #   @host ||= Rails.application.secrets.rabbit['host']
    #   @port ||= Rails.application.secrets.rabbit['port']
    #   @connection ||= Bunny.new(host: @host, port: @port).tap do |c|
    #     c.start
    #   end
    # end
  end
end
