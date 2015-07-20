require "thor"
require "json"
require "mechanize"
require "ifilter"

require "ro69/version"
require "ro69/live_repo_error"
require "ro69/commands/base"
require "ro69/commands/main"

module Ro69
  FilePath = File.expand_path("../../json/sites.json", __FILE__)
end
