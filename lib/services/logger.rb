#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'dotenv'

require 'slnky/service'

Dotenv.load

module Slnky
  module Service
    class Logger < Base
    end
  end
end

Slnky::Service::Logger.new(ENV['SLNKY_URL']).start
