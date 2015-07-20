require "thor"
require "json"
require "mechanize"
require "ifilter"
require "sanitize"

require "ro69/version"
require "ro69/live_repo_error"
require "ro69/commands/base"
require "ro69/commands/main"

module Ro69
  BASE_URI = "http://ro69.jp"
end
