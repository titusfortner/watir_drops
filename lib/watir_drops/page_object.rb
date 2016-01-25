require 'active_support/inflector'

module WatirDrops
  class PageObject

    class << self
      def page_url
        define_method("goto") do |*args|
          browser.goto yield(*args)
        end
      end

      def elements
        @elements ||= []
      end

      def element(name, &block)
        define_method(name) do |*args|
          self.instance_exec(*args, &block)
        end

        define_method(name.to_s.pluralize) do |*args|
          selector = self.instance_exec(*args, &block).instance_variable_get('@selector')
          element_type = selector.delete(:tag_name) || 'element'
          browser.send(element_type.pluralize, selector)
        end


        define_method("#{name}=") do |val|
          watir_element = self.instance_exec &block
          watir_element.wait_until_present
          case watir_element
            when Watir::Radio
              watir_element.set if val
            when Watir::CheckBox
              val ? watir_element.set : watir_element.clear
            when Watir::Select
              watir_element.select val
            when Watir::Button
              watir_element.click
            # TODO - Email & Password types are not set to UserEditable in Watir
            when Watir::Input
              watir_element.wd.clear
              watir_element.send_keys val
            else
              watir_element.click if val
          end
        end

        elements << {name.to_sym => block}
      end

      def visit(*args)
        new.tap do |page|
          page.goto(*args)
          yield if block_given?
        end
      end

      def use
        new.tap { yield if block_given? }
      end

    end

    attr_reader :browser

    def initialize
      @browser = WatirSession.browser
    end

    def fill_form(model)
      intersect = self.class.elements.map(&:keys).flatten & model.keys
      intersect.each do |val|
        self.send("#{val}=", model.send(val))
      end
    end

    def title
      browser.title
    end

    def url
      browser.url
    end

  end
end
