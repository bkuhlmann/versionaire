# Versionaire

[![Gem Version](https://badge.fury.io/rb/versionaire.svg)](http://badge.fury.io/rb/versionaire)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/versionaire.svg)](https://codeclimate.com/github/bkuhlmann/versionaire)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/versionaire/coverage.svg)](https://codeclimate.com/github/bkuhlmann/versionaire)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/versionaire.svg)](https://gemnasium.com/bkuhlmann/versionaire)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/versionaire.svg?style=svg)](https://circleci.com/gh/bkuhlmann/versionaire)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

Provides immutable, thread-safe, semantic versioning.

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

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

# Features

- Provides [Semantic Versioning](http://semver.org).
- Provides immutable, thread-safe version instances.
- Provides conversions (casts) from a `String`, `Array`, `Hash`, or `Version` to a `Version`.

# Screencasts

[![asciicast](https://asciinema.org/a/40455.png)](https://asciinema.org/a/40455)

# Requirements

0. [Ruby 2.4.x](https://www.ruby-lang.org)

# Setup

For a secure install, type the following (recommended):

    gem cert --add <(curl --location --silent https://www.alchemists.io/gem-public.pem)
    gem install versionaire --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification
while allowing the installation of unsigned dependencies since they are beyond the scope of this
gem.

For an insecure install, type the following (not recommended):

    gem install versionaire

Add the following to your Gemfile:

    gem "versionaire"

# Usage

## Initialization

A new version can be initialized in a variety of ways:

    Versionaire::Version.new                                    # "0.0.0"
    Versionaire::Version.new major: 1                           # "1.0.0"
    Versionaire::Version.new major: 1, minor: 2                 # "1.2.0"
    Versionaire::Version.new major: 1, minor: 2, maintenance: 3 # "1.2.3"

## Equality

### Value (`#==`)

Equality is deterimined by the state of the object. This means that a version is equal to another
version as long as all of the values (i.e. state) are equal to each other. Example:

    version_a = Versionaire::Version.new major: 1
    version_b = Versionaire::Version.new major: 2
    version_c = Versionaire::Version.new major: 1

    version_a == version_a # true
    version_a == version_b # false
    version_a == version_c # true

Knowning this, versions can be compared against one another too:

    version_a > version_b                   # false
    version_a < version_b                   # true
    version_a.between? version_c, version_b # true

### Hash (`#eql?`)

Behaves exactly as `#==`.

### Case (`#===`)

Behaves exactly as `#==`.

### Identity (`#equal?`)

Works like any other standard Ruby object where an object is equal only to itself.

    version_a = Versionaire::Version.new major: 1
    version_b = Versionaire::Version.new major: 2
    version_c = Versionaire::Version.new major: 1

    version_a.equal? version_a # true
    version_a.equal? version_b # false
    version_a.equal? version_c # false

## Conversions

### Function (Casting)

The `Versionaire::Version` function is provided for explicit casting to a version:

    version = Versionaire::Version.new major: 1

    Versionaire::Version "1.0.0"
    Versionaire::Version [1, 0, 0]
    Versionaire::Version major: 1, minor: 0, maintenance: 0
    Versionaire::Version version

Each of these conversions will result in a version object that represents "1.0.0". When attempting
to convert an unsupported type, a `Versionaire::Errors::Conversion` exception will be thrown.

### Implicit

Implicit conversion to a `String` is supported:

    "1.0.0".match Versionaire::Version.new(major: 1) # <MatchData "1.0.0">

### Explicit

Explicit conversion to a `String`, `Array`, or `Hash` is supported:

    version = Versionaire::Version.new

    version.to_s # "0.0.0"
    version.to_a # [0, 0, 0]
    version.to_h # {major: 0, minor: 0, maintenance: 0}

## Math

Versions can be added and subtracted from each other.

### Addition

    version_1 = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    version_2 = Versionaire::Version.new major: 2, minor: 5, maintenance: 7
    version_1 + version_2 # "3.7.10"

### Subtraction

    version_1 = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    version_2 = Versionaire::Version.new major: 1, minor: 1, maintenance: 1
    version_1 - version_2 # "0.1.2"

    version_1 = Versionaire::Version.new major: 1
    version_2 = Versionaire::Version.new major: 5
    version_1 - version_2 # Fails with a Versionaire::Errors::NegativeNumber

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2016 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

# History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).
