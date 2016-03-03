source 'https://rubygems.org'

ruby '2.2.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'

group :production do
  gem 'unicorn'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
gem 'bootstrap-sass'
gem 'devise'
gem 'haml-rails'
gem 'simple_form'
gem 'therubyracer', :platform=>:ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'thin'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'better_errors'
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.6'
  gem 'capistrano-rails-console', '~> 1.0.2'
  gem 'capistrano-unicorn-nginx', '~> 3.4.0'
  gem 'foreman'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
  gem "airbrussh", :require => false
end

gem 'dotenv-rails'
# gem 'bunny'
gem 'amqp'
gem 'slnky'#, github: 'shawncatz/slnky', branch: 'master'
