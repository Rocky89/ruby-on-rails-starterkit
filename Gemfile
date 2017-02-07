source 'https://rubygems.org'

ruby '2.4.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc2', '< 5.1'
# Use pg as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read
# more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# HTML Abstraction Markup Language
gem 'haml'
# Flexible authentication solution for Rails based on Warden
gem 'devise'
# framework for creating elegant backends for website administration
gem 'activeadmin', github: 'activeadmin'
# Bootstrap 4 ruby gem for Ruby on Rails
gem 'bootstrap', '~> 4.0.0.alpha3'
# provides a clean layer between the model and the controller
gem 'active_model_serializers'
# Cross-Origin Resource Sharing in case off a public API
# gem 'rack-cors'
# protect our API from DDoS, brute force attacks, hammering, or even to monetize
# with paid usage limits
gem 'rack-attack'
# authorization library which restricts what resources a given user is allowed
# to access
gem 'cancancan'
# ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT)
gem 'jwt'
# DSL and Rails engine for documenting your RESTful API
gem 'apipie-rails'

source 'https://rails-assets.org' do
  # JavaScript library for efficiently making an absolutely positioned element
  # stay next to another element on the page
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platform: :mri
  # testing framework for Rails
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener'
  # Access an IRB console on exception pages or by using <%= console %> anywhere
  # in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # A Ruby code quality reporter.
  gem 'rubycritic'
  # Ruby static code analyzer
  gem 'rubocop'
  # checks for security vulnerabilities
  gem 'brakeman'
  # Code smell detector for Ruby
  gem 'reek'
end

# Gemfile
group :test do
  # cleaning your database
  gem 'database_cleaner'
  # a fixtures replacement with a straightforward definition syntax
  gem 'factory_girl_rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
