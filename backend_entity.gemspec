require_relative 'lib/backend_entity/version'

# rubocop:disable Layout/LineLength
Gem::Specification.new do |spec|
  spec.name = 'backend_entity'
  spec.version = BackendEntity::VERSION
  spec.authors = ['Micha']
  spec.email = ['onedivzero@gmx.de']

  spec.summary = 'An abstraction for building a simple Rails-Backend.'
  spec.description = 'BackendEntity reduces the complexity of building a Rails-Backend by providing a simple abstraction.'
  spec.homepage = 'https://github.com/OneDivZero/backend_entity'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/OneDivZero/backend_entity'
  spec.metadata['changelog_uri'] = 'https://github.com/OneDivZero/backend_entity/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Dependencies for this gem:
  spec.add_dependency 'rails', '~> 7' # TODO: At least Rails 6.x should be acceptable #4

  # Development dependencies for this gem:
  # spec.add_development_dependency 'temping' # TODO: This may or should be removed! #4

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
# rubocop:enable Layout/LineLength
