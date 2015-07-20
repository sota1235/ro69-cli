module Ro69
  module Commands
    class Base < Thor
      def initialize(*args)
        super
        initialize_mechanize
      end

      private
      def initialize_mechanize
        @agent = Mechanize.new
      end
    end
  end
end
