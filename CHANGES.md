# v4.0.1 (2018-01-01)

- Updated to Gemsmith 11.0.0.

# v4.0.0 (2018-01-01)

- Updated Code Climate badges.
- Updated Code Climate configuration to Version 2.0.0.
- Updated to Ruby 2.4.3.
- Updated to Rubocop 0.52.0.
- Updated to Ruby 2.5.0.
- Removed documentation for secure installs.
- Updated to Apache 2.0 license.
- Refactored code to use Ruby 2.5.0 `Array#append` syntax.

# v3.3.1 (2017-11-19)

- Updated to Git Cop 1.7.0.
- Updated to Rake 12.3.0.

# v3.3.0 (2017-10-29)

- Added Bundler Audit gem.
- Added dynamic formatting of RSpec output.
- Updated to Gemsmith 10.2.0.
- Updated to Rubocop 0.50.0.
- Updated to Rubocop 0.51.0.
- Updated to Ruby 2.4.2.
- Removed Pry State gem.

# v3.2.0 (2017-07-16)

- Added Circle CI support.
- Added Git Cop code quality task.
- Updated CONTRIBUTING documentation.
- Updated GitHub templates.
- Updated README headers.
- Updated gem dependencies.
- Updated to Awesome Print 1.8.0.
- Updated to Gemsmith 10.0.0.
- Removed Travis CI support.

# v3.1.0 (2017-05-06)

- Fixed Travis CI configuration to not update gems.
- Added code quality Rake task.
- Updated Guardfile to always run RSpec with documentation format.
- Updated README semantic versioning order.
- Updated RSpec configuration to output documentation when running.
- Updated RSpec spec helper to enable color output.
- Updated Rubocop configuration.
- Updated Rubocop to import from global configuration.
- Updated contributing documentation.
- Updated to Gemsmith 9.0.0.
- Updated to Ruby 2.4.1.
- Removed Code Climate code comment checks.
- Removed `.bundle` directory from `.gitignore`.

# v3.0.0 (2017-01-22)

- Updated Rubocop Metrics/LineLength to 100 characters.
- Updated Rubocop Metrics/ParameterLists max to three.
- Updated Travis CI configuration to use latest RubyGems version.
- Updated gemspec to require Ruby 2.4.0 or higher.
- Updated to Rubocop 0.47.
- Updated to Ruby 2.4.0.
- Removed Rubocop Style/Documentation check.

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
