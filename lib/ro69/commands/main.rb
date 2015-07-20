module Ro69
  module Commands
    class Main < Base
      def initialize(*args)
        super

        @sites = open(Ro69::FilePath) do |json|
          JSON.load(json)
        end
      end

      desc "version", "version"
      def version
        puts "#{Ro69::Version}"
      end

      desc "liverepo", "ro69 live report list top 20"
      def liverepo(category = "all")
        case category
        when "all"
          category_id = 0
        when "japan"
          category_id = 1
        when "foreign"
          category_id = 2
        else
          raise
        end

        url = @sites["live_report_url"] + category_id.to_s

        @agent.get(url).search("h3.ttl_l > a").each do |item|
          puts "#{item.attribute('title')} #{@sites["base_url"]}#{item.attribute('href')}"
        end
      end
    end
  end
end