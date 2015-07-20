module Ro69
  module Commands
    class Main < Base
      DELIMITER = ". "

      desc "version", "version"
      def version
        puts "#{::Ro69::VERSION}"
      end

      desc "liverepo", "ro69 live report list top 20"
      def liverepo(category = "all")
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
        rescue LiveRepoError => ex
          STDERR.puts ex.message
          exit 1
        end

        query_string = "category=#{category_id}"
        url = "#{::Ro69::BASE_URI}/live?category=#{category_id}"

        storage = {}
        @agent.get(url).search("h3.ttl_l > a").each_with_index do |item, num|
          title = item.attribute("title").value
          href = ::Ro69::BASE_URI + item.attribute("href").value

          storage.store(num, {title: title, href: href})
        end

        target = storage.each_with_object([]) do |(num, object), array|
        array << num.to_s + DELIMITER + object[:title]
        end

        select_num = Ifilter.filtering(target).split(DELIMITER).first.to_i
        select_url = storage[select_num][:href]

        article = Sanitize.clean @agent.get(select_url).search("div.article_box_inner")
        STDOUT.puts article
      end
    end
  end
end
