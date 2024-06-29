# frozen_string_literal: true

require_relative 'lib/ownerrez/version'

Gem::Specification.new do |spec|
  spec.name = 'ownerrez-ruby'
  spec.version = OwnerRez::VERSION
  spec.authors = ['Brendan Tendrich']
  spec.email = ['brendan@tendrich.net']

  spec.summary = 'OwnerRez property management system API'
  spec.description = 'Write a longer description or delete this line.'
  spec.homepage = 'http://example.com/'
  spec.required_ruby_version = '>= 3.3.2'

  spec.metadata['allowed_push_host'] = ''

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'http://example.com/'
  spec.metadata['changelog_uri'] = 'http://example.com/'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'vcr', '~> 6.2.0'
  spec.add_development_dependency 'webmock', '~> 3.23.1'

  spec.add_dependency 'faraday'
  spec.add_dependency 'forwardable', '~> 1.3.3'
  spec.add_dependency 'json'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
