module ActionController

  module ZombifyController

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_zombify
        class_eval <<-EOV
          def render(options = nil, extra_options = {}, &block) #:doc:
            super  
            doc = Nokogiri::HTML(response.body)
            doc.css('h1, h2, h3, h4, h5, p, span, li, a, blockquote').each do |header|
              content = HTML::WhiteListSanitizer.new.sanitize(header.content)
              logger.debug "header > " + content
              response.body = content.zombify()
            end
          end
        EOV
      end
    end
  end
end

ActionController::Base.send(:include, ActionController::ZombifyController)