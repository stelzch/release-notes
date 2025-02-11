![Imgur](https://i.imgur.com/vTgHEyJ.png)

# Release::Notes

[![Gem Version](https://badge.fury.io/rb/release-notes.svg)](https://badge.fury.io/rb/release-notes)
[![Documentation](http://img.shields.io/badge/rdoc-Release::Notes-blue.svg)](https://www.rubydoc.info/gems/release-notes)
[![Inline docs](http://inch-ci.org/github/dvmonroe/release-notes.svg?branch=master)](http://inch-ci.org/github/dvmonroe/release-notes)

[![Build Status](https://travis-ci.org/dvmonroe/release-notes.svg?branch=master)](https://travis-ci.org/dvmonroe/release-notes)
[![Code Climate](https://codeclimate.com/github/dvmonroe/release-notes/badges/gpa.svg)](https://codeclimate.com/github/dvmonroe/release-notes)
[![Test Coverage](https://codeclimate.com/github/dvmonroe/release-notes/badges/coverage.svg)](https://codeclimate.com/github/dvmonroe/release-notes/coverage)

## Automated release notes based on your project's git log.

Release::Notes is a small wrapper around your project's git log. The gem is
intended to help increase visability to all team members and/or stakeholders with
automated documentation of important changes made to your code base for a given production
deployment based on tags and labels in your commit messages.

Release::Notes is different than a changelog. Though it can log all commits, it's
meant for situations where other team members in your organization need to know about key changes
to the production software. These key changes are determined by the labeling you set forth
in the configuration for features, bugs and misc commits.
If you're looking for a comprehnsive changelog that reflects resolved github issues and uses the
github api, I'd suggest you look at something else like
[github-changelog-generator](https://github.com/github-changelog-generator/github-changelog-generator).

Not looking for a tested gem or prefer the rawness of a bash script? Checkout the similar
[bash implementation](https://gist.github.com/dvmonroe/300226a1ed4435fb38d72e72e1bbc5a0)

## Getting Started

Add this line to your application's Gemfile:

```ruby
gem 'release-notes'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install release-notes
```

After you install Release::Notes, generate the intializer file:

```sh
# rails
$ rails generate release:notes:install

# non-rails
$ bundle exec rake release:notes:install
```

## Configure

Override any of these defaults in `config/initializers/release_notes.rb`:

```ruby
# frozen_string_literal: true

Release::Notes.configure do |config|
  # The absolute path of your generated log.
  # Defaults to `./RELEASE_NOTES.md`.
  # @return [String]
  config.output_file = "./RELEASE_NOTES.md"

  # The absolute path of the temporary generated log.
  # Defaults to `./release-notes.tmp.md`.
  # @return [String]
  config.temp_file = "./release-notes.tmp.md"

  # Determines whether to print commits with more than one parent.
  # Defaults to `false`. For more, see
  # [Git Log Docs](https://git-scm.com/docs/git-log)
  # @return [Boolean]
  config.include_merges = false

  # Match the regular expression limiting patterns without regard to letter case
  # when printing your git log.
  # Defaults to `true`. For more, see
  # [Git Log Docs](https://git-scm.com/docs/git-log)
  # @return [Boolean]
  config.ignore_case = true

  # Consider the limiting patterns to be extended regular expressions patterns
  # when printing your git log.
  # Defaults to `true`. For more, see
  # [Git Log Docs](https://git-scm.com/docs/git-log)
  # @return [Boolean]
  config.extended_regex = true

  # Controls the header used in your generated log for all tags.
  # "tag" and "date" are the two valid options
  # Defaults to `tag`.
  # @return [String]
  config.header_title = "tag"

  # Allows you to specify what information you want to print from your git log
  # Defaults to `%s` for subject. For more, see
  # [Git Log Docs](https://git-scm.com/docs/git-log)
  # @return [String]
  config.bug_labels = %w(Fix Update)

  # Controls the labels grepped for in your commit subjects that will
  # be add under you feature title
  # Defaults to `%w(Add Create)`.
  # @return [Array]
  config.feature_labels = %w(Add Create)

  # Controls the labels grepped for in your commit subjects that will
  # be add under you miscellaneous title
  # Defaults to `%w(Refactor)`.
  # @return [Array]
  config.misc_labels = %w(Refactor)

  # Controls the title used in your generated log for all bugs listed
  # Defaults to `**Fixed bugs:**`.
  # @return [String]
  config.bug_title = "**Fixed bugs:**"

  # Controls the title used in your generated log for all features listed
  # Defaults to `**Implemented enhancements:**`.
  # @return [String]
  config.feature_title = "**Implemented enhancements:**"

  # Controls the title used in your generated log for all misc commits listed
  # Defaults to `**Miscellaneous:**`.
  # @return [String]
  config.misc_title = "**Miscellaneous:**"

  # Controls the title used in your generated log for all commits listed
  # Defaults to `**Other:**`.
  # @return [String]
  config.log_all_title = "**Other:**"

  # Controls whether all logs that do not match the other labels are listed
  # Defaults to `false`
  # @return [Boolean]
  config.log_all = false

  # The labels grepped for in your commit subject that you want to linkify.
  # The index within the array must match the index for the site
  # in `:link_to_humanize` and `:link_to_sites`.
  # Defaults to `[]`.
  # @return [Array]
  config.link_to_labels = %w()

  # The humanized output that you'd like to represent the associated `:link_to_label`
  # The index within the array must match the index for the site
  # in `:link_to_label` and `:link_to_sites`.
  # Defaults to `[]`.
  # @return [Array]
  config.link_to_humanize = %w()

  # The url for the site that you'd like to represent the associated `:link_to_label`
  # The index within the array must match the index for the site
  # in `:link_to_label` and `:link_to_humanize`.
  # Defaults to `[]`.
  # @return [Array]
  config.link_to_sites = %w()

  # Sets the timezone that should be used for setting the date.
  # Defaults to `America/New_York`. For more, see
  # [ActiveSupport Time Zones](http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html)
  # @return [String]
  config.timezone = "America/New_York"

  # Controls whether your commit subject labels should be removed from the final
  # ouput of your message on the generated log.
  # Defaults to `false`.
  # @return [Boolean]
  config.prettify_messages = false

  # If a commit message contains words that match more than
  # one group of labels as defined in your configuration, the output
  # will only contain the commit once.
  # Defaults to `true`.
  # @return [Boolean]
  config.single_label = true

  # Controls what will be passed to the format flag in `git for-each-ref`
  # Defaults to `tag`.
  # @return [String]
  config.for_each_ref_format = "tag"

  # Determines whether to use the last two tags to
  # find commits for the output or if this gem should just
  # find all commits after previous tag
  # Defaults to `true`.
  # @return [Boolean]
  config.update_release_notes_before_tag = true
end
```

## Usage

Install the binstub

```sh
$ bundle binstubs release-notes
```

and run

```
$ exe/release-notes help generate

Usage:
  release-notes generate

Options:
  -t, [--tag=TAG]                              # The latest tag to use on the file title if the tag is not yet pushed
  -r, [--force-rewrite], [--no-force-rewrite]  # Force release-notes to look at all previous tags and rewrite the output file
  -i, [--ignore-head], [--no-ignore-head]      # If updating your changelog and you don't want the latest commits from the last tag to HEAD in a single instance of running, set to true

Generate release notes

```

some sample ideas:


```sh
# make sure to pass your tag if updating before you've pushed the latest tag
$ bin/release-notes -t v0.2.0
# OR if running for the first time on a project that might have commits after the latest tag
$ bin/release-notes --ignore-head
# OR if using an output file that already exists in a project but would like to rerun all git tags
$ bin/release-notes --force-rewrite
```


## Important Notes

- Your project must tag releases(release-notes uses the tag date to output the changes)
  (PR's to make this more flexible are welcome)
- Linking is opinionated and will link to a URI structure of `#{site-url}#{issue_number}`. It
  will ouput something like: `[HONEYBADGER #33150353](https://app.honeybadger.io/projects/9999/faults/33150353)`.
  This also means that your link_to_labels have to be something like `['HB #']` (PR's to make this more flexible are welcome)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dvmonroe/release-notes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributing Guide](https://github.com/dvmonroe/release-notes/blob/master/CONTRIBUTING.md).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
