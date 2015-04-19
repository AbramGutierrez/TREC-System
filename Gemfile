source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
gem 'coffee-script-source', '1.8.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use foundation for stylesheets
gem 'foundation-rails'

# Necessary to prevent no timezone data errors on Windows
gem 'tzinfo-data'

# Allow use of haml for views
gem 'haml'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#paginate for tables
  gem 'will_paginate', '~> 3.0.6'
  
#resize image
  gem 'rmagick', '~>2.13.2'
  
#upload image
  gem "carrierwave"



group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  # Use RSpec for TDD
  gem 'rspec-rails'
  
  #TDD 
  gem 'factory_girl'
  
end

group :test do
	gem 'cucumber-rails', :require => false
	gem 'cucumber-rails-training-wheels'
	gem 'database_cleaner' # to clear Cucumber's test database between runs
	gem 'capybara'
	gem 'launchy' # a useful debugging aid for user stories
	
	gem 'simplecov', '~> 0.9.0', :require => false
end

group :production do
	gem 'pg'
	gem 'rails_12factor'
end

