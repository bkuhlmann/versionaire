<p align="center">
  <img src="versionaire.png" alt="Versionaire Icon"/>
</p>

# Versionaire

[![Gem Version](https://badge.fury.io/rb/versionaire.svg)](http://badge.fury.io/rb/versionaire)
[![Code Climate Maintainability](https://api.codeclimate.com/v1/badges/e61fa9230ecc0bfa6f07/maintainability)](https://codeclimate.com/github/bkuhlmann/versionaire/maintainability)
[![Code Climate Test Coverage](https://api.codeclimate.com/v1/badges/e61fa9230ecc0bfa6f07/test_coverage)](https://codeclimate.com/github/bkuhlmann/versionaire/test_coverage)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/versionaire.svg?style=svg)](https://circleci.com/gh/bkuhlmann/versionaire)

Provides an immutable, thread-safe, and semantic version type when managing versions within your
applications.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Features](#features)
  - [Screencasts](#screencasts)
  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Usage](#usage)
    - [Initialization](#initialization)
    - [Equality](#equality)
      - [Value (`#==`)](#value-)
      - [Hash (`#eql?`)](#hash-eql)
      - [Case (`#===`)](#case-)
      - [Identity (`#equal?`)](#identity-equal)
    - [Conversions](#conversions)
      - [Function (Casting)](#function-casting)
      - [Implicit](#implicit)
      - [Explicit](#explicit)
    - [Comparisons](#comparisons)
    - [Math](#math)
      - [Addition](#addition)
      - [Subtraction](#subtraction)
  - [Tests](#tests)
  - [Versioning](#versioning)
  - [Code of Conduct](#code-of-conduct)
  - [Contributions](#contributions)
  - [License](#license)
  - [History](#history)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Features

- Provides [Semantic Versioning](https://semver.org).
- Provides immutable, thread-safe version instances.
- Converts (casts) from a `String`, `Array`, `Hash`, or `Version` to a `Version`.

## Screencasts

[![asciicast](https://asciinema.org/a/278658.svg)](https://asciinema.org/a/278658)

## Requirements

1. [Ruby 2.6.x](https://www.ruby-lang.org).

## Setup

Type the following to install:

    gem install versionaire

Add the following to your Gemfile:

    gem "versionaire"

## Usage

### Initialization

A new version can be initialized in a variety of ways:

    Versionaire::Version.new                                    # "0.0.0"
    Versionaire::Version[major: 1]                              # "1.0.0"
    Versionaire::Version[major: 1, minor: 2]                    # "1.2.0"
    Versionaire::Version[major: 1, minor: 2, patch: 3]          # "1.2.3"

### Equality

#### Value (`#==`)

Equality is deterimined by the state of the object. This means that a version is equal to another
version as long as all of the values (i.e. state) are equal to each other. Example:

    version_a = Versionaire::Version[major: 1]
    version_b = Versionaire::Version[major: 2]
    version_c = Versionaire::Version[major: 1]

    version_a == version_a # true
    version_a == version_b # false
    version_a == version_c # true

Knowning this, versions can be compared against one another too:

    version_a > version_b                   # false
    version_a < version_b                   # true
    version_a.between? version_c, version_b # true

#### Hash (`#eql?`)

Behaves exactly as `#==`.

#### Case (`#===`)

Behaves exactly as `#==`.

#### Identity (`#equal?`)

Works like any other standard Ruby object where an object is equal only to itself.

    version_a = Versionaire::Version[major: 1]
    version_b = Versionaire::Version[major: 2]
    version_c = Versionaire::Version[major: 1]

    version_a.equal? version_a # true
    version_a.equal? version_b # false
    version_a.equal? version_c # false

### Conversions

#### Function (Casting)

The `Versionaire::Version` function is provided for explicit casting to a version:

    version = Versionaire::Version[major: 1]

    Versionaire::Version "1.0.0"
    Versionaire::Version [1, 0, 0]
    Versionaire::Version major: 1, minor: 0, patch: 0
    Versionaire::Version version

Each of these conversions will result in a version object that represents "1.0.0". When attempting
to convert an unsupported type, a `Versionaire::Errors::Conversion` exception will be thrown.

#### Implicit

Implicit conversion to a `String` is supported:

    "1.0.0".match Versionaire::Version[major: 1] # <MatchData "1.0.0">

#### Explicit

Explicit conversion to a `String`, `Array`, or `Hash` is supported:

    version = Versionaire::Version.new

    version.to_s # "0.0.0"
    version.to_a # [0, 0, 0]
    version.to_h # {major: 0, minor: 0, patch: 0}

### Comparisons

All versions are comparable which means any of the operators from the `Comparable` module will work.
Example:

    version_1 = Versionaire::Version "1.0.0"
    version_2 = Versionaire::Version "2.0.0"

    version_1 < version_2 # true
    version_1 <= version_2 # true
    version_1 == version_2 # false (see Equality section above for details)
    version_1 > version_2 # false
    version_1 >= version_2 # false
    version_1.between? version_1, version_2 # true
    version_1.clamp version_1, version_2 # version_1 (added in Ruby 2.4.0)

### Math

Versions can be added and subtracted from each other.

#### Addition

    version_1 = Versionaire::Version[major: 1, minor: 2, patch: 3]
    version_2 = Versionaire::Version[major: 2, minor: 5, patch: 7]
    version_1 + version_2 # "3.7.10"

#### Subtraction

    version_1 = Versionaire::Version[major: 1, minor: 2, patch: 3]
    version_2 = Versionaire::Version[major: 1, minor: 1, patch: 1]
    version_1 - version_2 # "0.1.2"

    version_1 = Versionaire::Version[major: 1]
    version_2 = Versionaire::Version[major: 5]
    version_1 - version_2 # Fails with a Versionaire::Errors::NegativeNumber

## Tests

To test, run:

    bundle exec rake

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2016 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).
