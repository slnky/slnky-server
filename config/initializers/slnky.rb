require 'slnky'
Slnky::Brain::Base.connect(Rails.application.secrets.redis)