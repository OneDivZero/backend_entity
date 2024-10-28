module BackendEntity
  module Controller
    extend ActiveSupport::Concern

    included do
      include BackendEntity::Reflection
      include BackendEntity::Fetching
      include BackendEntity::Routes
      include BackendEntity::Actions
    end
  end
end