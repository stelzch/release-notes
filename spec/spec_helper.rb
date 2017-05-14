# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'release/notes'
require 'aruba/rspec'
require 'pry-byebug'

::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require_relative f }

def restore_config
  Release::Notes.configuration = nil
  Release::Notes.configure {}
end
