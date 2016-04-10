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

  desc 'remove queues and exchanges'
  task :cleanup => :environment do
    base = "http://guest:guest@localhost:15672/api"
    queues = JSON.parse(RestClient.get("#{base}/queues/", accept: :json))
    queues.each do |q|
      url = "#{base}/%2f/#{URI.encode(q['name'])}"
      puts "queue: #{q['name'].inspect}"
      RestClient.delete(url)
    end

    exchanges = JSON.parse(RestClient.get("#{base}/exchanges/", accept: :json))
    exchanges.each do |x|
      next if !x['name'] || x['name'] == '' || x['name'] =~ /^amq/
      puts "exchange: #{x['name'].inspect}"
      url = "#{base}/exchanges/%2f/#{URI.encode(x['name'])}"
      RestClient.delete(url)
    end
  end
end
