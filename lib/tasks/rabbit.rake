namespace :rabbit do
  desc "Setup routing"
  task :setup => :environment do
    require "bunny"
    host = Rails.application.secrets.rabbit['host']
    port = Rails.application.secrets.rabbit['port']
    conn = Bunny.new(host: host, port: port)
    conn.start

    ch = conn.create_channel

    # get or create exchange
    ch.fanout("slnky.events")
    ch.fanout("slnky.logs")

    # get or create queue (note the durable setting)
    ch.queue("logger.events", durable: true).bind("slnky.events")
    ch.queue("service.events", durable: true).bind("slnky.events")
    ch.queue("logger.logs", durable: true).bind("slnky.logs")

    conn.close
  end
end
