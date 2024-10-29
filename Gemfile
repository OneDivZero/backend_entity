source 'https://rubygems.org'

rails_version = ENV['RAILS_VERSION'] || '∞'

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
  # gem 'minitest-macos-notification', platforms: :ruby, install_if: Machine.is_a_mac?
  gem 'minitest-macos-notification', platforms: :ruby
  gem 'rails-controller-testing'
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

platforms :ruby do
  if rails_version <= '5.0'
    gem 'sqlite3', '< 1.4'
  elsif (rails_version <= '8') || (RUBY_VERSION < '3')
    gem 'sqlite3', '< 2'
  else
    gem 'sqlite3'
  end
end
