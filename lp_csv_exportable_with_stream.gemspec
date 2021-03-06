# frozen_string_literal: true

require_relative 'lib/lp_csv_exportable_with_stream/version'

Gem::Specification.new do |spec|
  spec.name = 'lp_csv_exportable_with_stream'
  spec.version = LpCSVExportableWithStream::VERSION
  spec.authors = ['z22919456']
  spec.email = ['z22919456@gmail.com']

  spec.summary = 'Extension of lp_csv_exportable, let export file can be download by stream'
  spec.description = 'Export file with stream, free your thread'
  spec.homepage = 'https://github.com/z22919456/lp_csv_exportable_with_stream'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.4.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/z22919456/lp_csv_exportable_with_stream'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'lp_csv_exportable'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
