namespace :config do
  desc 'dump config'
  task :dump => :environment do
    puts get_secrets.to_yaml
  end

  desc 'dump config'
  task :brain => :environment do
    puts Slnky.brain.hget(:config, Rails.env).to_yaml
  end

  desc 'put config into brain'
  task :load => :environment do
    get_secrets.each do |service, config|
      config.each do |key, value|
        puts "hset(config.#{Rails.env}, '#{service}.#{key}', #{value})"
        # Slnky.brain.hset("config.#{Rails.env}", get_secrets)
      end
    end
  end

  def get_secrets
    secrets = JSON.parse(Rails.application.secrets.dup.to_json)
    secrets.delete('secret_token')
    secrets.delete('secret_key_base')
    secrets.merge!(secrets.delete('common'))
    secrets
  end
end