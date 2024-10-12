source 'https://rubygems.org'

# Specify your gem's dependencies in backend_entity.gemspec
gemspec

gem 'rake', '~> 13.0'

group :utils, :default do
  gem 'colorize'
end

group :test do
  gem 'guard'
  gem 'guard-minitest'
  gem 'minitest-focus'
  gem 'minitest-spec-rails', '~> 7.1'
end

group :development, :test do
  gem 'pry'
  gem 'pry-alias'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'rubocop', '~> 1.6', require: false
end
