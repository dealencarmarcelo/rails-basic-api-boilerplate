source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'

gem 'bcrypt', '~> 3.1.7'
gem 'jwt'

gem 'rack-cors'
gem 'bootsnap', '>= 1.4.4', require: false

gem 'simple_command'

group :development, :test do
  gem 'rspec-rails', '~> 4.0.2'  
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end