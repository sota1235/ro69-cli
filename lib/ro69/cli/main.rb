module Ro69
  module Cli
    class Main < Base
      desc "version", "version"
      def version
        puts "#{Ro69::VERSION}"
      end
    end
  end
end
