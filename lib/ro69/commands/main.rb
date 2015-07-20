module Ro69
  module Commands
    class Main < Base
      DELIMITER = ". "

      desc "version", "version"
      def version
        puts "#{::Ro69::VERSION}"
      end

      desc "report", "ro69 live report top 20"
      def report(category = "all")
        category_id = check_category category
        uri = "#{::Ro69::BASE_URI}/live?category=#{category_id}"
        selector = "h3.ttl_l > a"

        detail_uri = get_detail_uri uri, selector

        article = Sanitize.clean @agent.get(detail_uri).search("div.article_box_inner")
        STDOUT.puts article
      end

      desc "news", "ro69 news top 20"
      def news(category = "all")
        category_id = check_category category
        uri = "#{::Ro69::BASE_URI}/news?category_id=#{category_id}"
        selector = "h3.ttl_l > a"

        detail_uri = get_detail_uri uri, selector
        
        article = Sanitize.clean @agent.get(detail_uri).search("div.article_box_inner")
        STDOUT.puts article
      end

      private
      def check_category(category)
        begin 
          case category
          when "all"
            category_id = 0
          when "japan"
            category_id = 1
          when "foreign"
            category_id = 2
          else
            raise LiveRepoError, "option => (all|japan|foreign)"
          end
          category_id
        rescue LiveRepoError => ex
          STDERR.puts ex.message
          exit 1
        end
      end

      def get_detail_uri(uri, selector)
        storage = {}
        @agent.get(uri).search(selector).each_with_index do |item, num|
          title = item.attribute("title").value
          href = ::Ro69::BASE_URI + item.attribute("href").value
          storage.store(num, {title: title, href: href})
        end

        target = storage.each_with_object([]) do |(num, object), array|
          array << num.to_s + DELIMITER + object[:title]
        end

        select_num = Ifilter.filtering(target).split(DELIMITER).first.to_i
        detail_uri = storage[select_num][:href]
        detail_uri
      end
    end
  end
end
