module WatirDrops
  class PageObject

    class << self
      def page_url url
        define_method("goto") do
          browser.goto url
        end
      end

      def elements
        @elements ||= []
      end

      def element(name, &block)
        define_method(name) do |*args|
          self.instance_exec(*args, &block)
        end

        define_method("#{name}=") do |val|
          watir_element = self.instance_exec &block
          case watir_element
            when Watir::Radio
              watir_element.set val
            when Watir::CheckBox
              val ? watir_element.set : watir_element.clear
            when Watir::Select
              watir_element.select val
            when Watir::Button
              watir_element.click
            else
              watir_element.value = val
          end
        end

        elements << {name.to_sym => block}
      end

    end

    attr_reader :browser

    def initialize(browser=nil)
      @browser = browser || WatirDrops::Session.instance.browser
    end

    def visit
      goto if self.respond_to? :goto
      self
    end

    def title
      browser.title
    end

  end
end
