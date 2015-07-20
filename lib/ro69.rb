require "thor"
require "json"
require "mechanize"

require "ro69/version"
require "ro69/liverepoerror"
require "ro69/commands/base"
require "ro69/commands/main"

module Ro69
  FilePath = File.expand_path("../../json/sites.json", __FILE__)
end
