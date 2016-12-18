# v2.2.0 (2016-12-18)

- Fixed Rakefile support for RSpec, Reek, Rubocop, and SCSS Lint.
- Added `Gemfile.lock` to `.gitignore`.
- Updated Travis CI configuration to use defaults.
- Updated gem dependencies.
- Updated to Gemsmith 8.2.x.
- Updated to Rake 12.x.x.
- Updated to Rubocop 0.46.x.
- Updated to Ruby 2.3.2.
- Updated to Ruby 2.3.3.

# v2.1.0 (2016-11-13)

- Added Code Climate engine support.
- Added Reek support.
- Updated to Code Climate Test Reporter 1.0.0.
- Updated to Gemsmith 8.0.0.

# v2.0.0 (2016-11-01)

- Fixed Bash script header to dynamically load correct environment.
- Fixed Rakefile to safely load Gemsmith tasks.
- Fixed negative number check.
- Added frozen string literal pragma.
- Updated README to mention "Ruby" instead of "MRI".
- Updated README versioning documentation.
- Updated RSpec temp directory to use Bundler root path.
- Updated gemspec with conservative versions.
- Updated to Bundler 1.13.
- Updated to Gemsmith 7.7.0.
- Updated to RSpec 3.5.0.
- Updated to Rubocop 0.44.
- Removed CHANGELOG.md (use CHANGES.md instead).
- Removed Rake console task.
- Removed deprecated conversion error message strings.
- Removed gemspec description.
- Removed rb-fsevent development dependency from gemspec.
- Removed terminal notifier gems from gemspec.
- Removed unused "vendor" folder from gemspec.
- Refactored RSpec spec helper configuration.
- Refactored gemspec to use default security keys.

# v1.2.0 (2016-05-10)

- Fixed README screencast thumbnail.
- Fixed issue with array parameters being modified.
- Added version delimiter class method.
- Updated Rubocop PercentLiteralDelimiters and AndOr styles.
- Updated to Ruby 2.3.1.

# v1.1.0 (2016-04-03)

- Added GitHub issue and pull request templates.
- Added deprecations to `Versionaire::Errors::Conversion` messages.
- Added version conversion failure messages.
- Updated version conversion error messages.
- Refactored version converter.

# v1.0.0 (2016-03-26)

- Fixed conversion function format.
- Added Code Climate test coverage key to Travis CI configuration.
- Added Ruby 2.3+ requirements.
- Added bond, wirb, hirb, and awesome_print development dependencies.
- Added missing frozen string literal support.
- Added screencast to README.
- Updated README equality, conversion, and math documentation.
- Updated gemspec summary and description.
- Refactored `Version.format` as `Version.string_format`.
- Refactored conversion function.
- Refactored version format regular expression for readability.

# v0.1.0 (2016-03-19)

- Initial version.
