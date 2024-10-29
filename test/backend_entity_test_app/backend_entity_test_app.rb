ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'

#-----------------------------------------------------------------------------------------------------------------------
# Setup of database-connection for testing
#-----------------------------------------------------------------------------------------------------------------------

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

#-----------------------------------------------------------------------------------------------------------------------
# Setup of rails-test-app
#-----------------------------------------------------------------------------------------------------------------------

module BackendEntityTestApp
  class Application < Rails::Application
    # config.secret_key_base = 'test'
    config.secret_token = 'BackendEntityTestAppToken'
    config.session_store :cookie_store, key: '_backend_entity_test_app_session'
    config.active_support.deprecation = :log
    config.eager_load = false

    if ((Rails::VERSION::MAJOR >= 7) && (Rails::VERSION::MINOR >= 1)) || (Rails::VERSION::MAJOR >= 8)
      config.action_dispatch.show_exceptions = :none
    else
      config.action_dispatch.show_exceptions = false
    end

    config.root = File.dirname(__FILE__)
    config.logger = ActiveSupport::Logger.new($stdout)

    # config.action_mailer.delivery_method = :test
    # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

    config.after_initialize do |app|
      app.routes_reloader.reload!
    end
  end
end

BackendEntityTestApp::Application.initialize!

#-----------------------------------------------------------------------------------------------------------------------
# Setup of routing
#-----------------------------------------------------------------------------------------------------------------------

BackendEntityTestApp::Application.routes.draw do
  resources :examples

  namespace :backend do
    resources :examples
  end
end

#-----------------------------------------------------------------------------------------------------------------------
# Setup of controllers
#-----------------------------------------------------------------------------------------------------------------------

class ExamplesController < ::ActionController::Base
  include BackendEntity::Controller
end

class AnotherExamplesController < ::ActionController::Base
  include BackendEntity::Controller
end

class ::InheritedExamplesController < ::ActionController::Base
  include BackendEntity::Controller
end

module Backend
  class ExamplesController < ::ActionController::Base
    include BackendEntity::Controller

    before_action :load_entity, only: %i[show edit update destroy new edit]
  end
end

#-----------------------------------------------------------------------------------------------------------------------
# Setup of models
#-----------------------------------------------------------------------------------------------------------------------

class Example < ActiveRecord::Base; end

class AnotherExample < ActiveRecord::Base; end

class InheritedExample < ActiveRecord::Base; end

#-----------------------------------------------------------------------------------------------------------------------
# Setup of database
#-----------------------------------------------------------------------------------------------------------------------

class CreateAllTables < ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration
  def self.up
    create_table(:examples) { |t| t.string :name }
    create_table(:another_examples) { |t| t.string :name }
    create_table(:inherited_examples) { |t| t.string :type; t.string :name }
  end
end
