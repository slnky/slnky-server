namespace :slnky do
  namespace :service do
    desc 'restart all connected services'
    task :restart => :environment do
      Services::Publisher.publish("events", {name: 'slnky.service.restart', payload: {rake: true}})
    end
  end
end
