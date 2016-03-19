# Versionaire

[![Gem Version](https://badge.fury.io/rb/versionaire.svg)](http://badge.fury.io/rb/versionaire)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/versionaire.svg)](https://codeclimate.com/github/bkuhlmann/versionaire)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/versionaire/coverage.svg)](https://codeclimate.com/github/bkuhlmann/versionaire)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/versionaire.svg)](https://gemnasium.com/bkuhlmann/versionaire)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/versionaire.svg)](https://travis-ci.org/bkuhlmann/versionaire)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

Provides immutable, semantic versioning.

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Screencasts](#screencasts)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
  - [Basic](#basic)
  - [Math](#math)
    - [Add](#add)
    - [Subtract](#subtract)
  - [Comparisons](#comparisons)
  - [Equality](#equality)
  - [Identity](#identity)
  - [Implicit Conversions](#implicit-conversions)
  - [Explicit Conversions](#explicit-conversions)
  - [Conversions (Casting)](#conversions-casting)
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
- Provides immutable version instances.
- Provides conversions (casts) from a `String`, `Array`, `Hash`, or `Version` to a new `Version`.
- Provides impicit conversion to a `String`.
- Provides explicit conversions to a `String`, `Array`, and a `Hash`.

# Screencasts

TBD

# Requirements

0. [MRI 2.3.0](https://www.ruby-lang.org)

# Setup

For a secure install, type the following (recommended):

    gem cert --add <(curl --location --silent https://www.alchemists.io/gem-public.pem)
    gem install versionaire --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification while
allowing the installation of unsigned dependencies since they are beyond the scope of this gem.

For an insecure install, type the following (not recommended):

    gem install versionaire

Add the following to your Gemfile:

    gem "versionaire"

# Usage

## Basic

A new version can be initialized in a variety of ways:

    Versionaire::Version.new                                    # "0.0.0"
    Versionaire::Version.new major: 1                           # "1.0.0"
    Versionaire::Version.new major: 1, minor: 2                 # "1.2.0"
    Versionaire::Version.new major: 1, minor: 2, maintenance: 3 # "1.2.3"

## Math

Versions can be added and subtracted from each other.

### Add

    version_1 = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    version_2 = Versionaire::Version.new major: 2, minor: 5, maintenance: 7
    version_1 + version_2 # "3.7.10"

### Subtract

    version_1 = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    version_2 = Versionaire::Version.new major: 1, minor: 1, maintenance: 1
    version_1 - version_2 # "0.1.2"

    version_1 = Versionaire::Version.new major: 1
    version_2 = Versionaire::Version.new major: 5
    version_1 - version_2 # Fails with a Versionaire::Errors::NegativeNumber

## Comparisons

Versions can be compared against other versions:

    version_1 = Versionaire::Version.new major: 1
    version_2 = Versionaire::Version.new major: 5

    version_1 > version_2  # false
    version_1 == version_2 # false
    version_1 < version_2  # true

Versions can't be compared to similar objects:

    version = Versionaire::Version.new major: 1

    version == "1.0.0"                              # false
    version == [1, 0, 0]                            # false
    version == {major: 1, minor: 0, maintenance: 0} # false

## Equality

Equality is based on the values that make up the version, not identity.

    version = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    identical = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    different = Versionaire::Version.new major: 3

    version == version   # true
    version == identical # true
    version == different # false

This is the same behavior for `#eql?` method too.

## Identity

Identity is composed of the values that make up the version plus the class:

    version = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    identical = Versionaire::Version.new major: 1, minor: 2, maintenance: 3
    different = Versionaire::Version.new major: 3

    version.hash   # -4162833121614102126
    identical.hash # -4162833121614102126
    different.hash # -2082793513660996236

## Implicit Conversions

Implicit conversion to a `String` is supported:

    "1.0.0".match Versionaire::Version.new(major: 1) # <MatchData "1.0.0">

## Explicit Conversions

Explicit converting to a `String`, `Array`, or `Hash` is supported:

    version = Versionaire::Version.new

    version.to_s # "0.0.0"
    version.to_a # [0, 0, 0]
    version.to_h # {major: 0, minor: 0, maintenance: 0}

## Conversions (Casting)

The `Versionaire::Version` function is provided for explicit conversion (casting) to a new version:

    version = Versionaire::Version.new major: 1

    Versionaire::Version "1.0.0"
    Versionaire::Version [1, 0, 0]
    Versionaire::Version major: 1, minor: 0, maintenance: 0
    Versionaire::Version version

Each of these conversions will result in a new version object that is equal to "1.0.0". When attempting to convert an
unsupported type, a `Versionaire::Errors::Conversion` exception will be thrown.

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2016 [Alchemists](https://www.alchemists.io).
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at [Alchemists](https://www.alchemists.io).
