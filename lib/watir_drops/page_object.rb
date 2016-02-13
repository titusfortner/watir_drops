require 'active_support/inflector'

module WatirDrops
  class PageObject

    class << self

      attr_writer :element_list

      def page_url
        define_method("goto") do |*args|
          browser.goto yield(*args)
        end
      end

      def element_list
        @element_list ||= []
      end

      def inherited(subclass)
        subclass.element_list = element_list.dup
      end

      Watir::Container.instance_methods(false).each do |class_method_name|
        define_method(class_method_name) do |instance_method_name, locator = {}, &block|
          define_method(instance_method_name) do |*args|
            if block.is_a? Proc
              raise StandardError, 'Can not define element with both locator and block' unless locator.empty?
              expected_class = browser.send(class_method_name).class
              element = self.instance_exec(*args, &block)
              return element if element.is_a? expected_class
              raise StandardError, "#{instance_method_name} method was defined as a #{expected_class}, but is a #{element.class}"
            else
              browser.send(class_method_name, locator)
            end
          end

          define_method("#{instance_method_name}=") do |val|
            watir_element = self.send(instance_method_name)
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

          define_method(instance_method_name.to_s.pluralize) do |*args|
            if block.is_a? Proc
              expected_class = browser.send(class_method_name.to_s.pluralize).class

              single_element = self.instance_exec(*args, &block)
              parent = single_element.instance_variable_get('@parent')
              selector = single_element.instance_variable_get('@selector')
              element_type = selector.delete(:tag_name) || 'element'
              element = parent.send(element_type.pluralize, selector)

              return element if element.is_a?(expected_class) || class_method_name == :element
              raise StandardError, "#{instance_method_name} method was defined as a #{expected_class}, but is a #{element.class}"
            else
              browser.send(class_method_name.to_s.pluralize, locator)
            end
          end

          element_list << instance_method_name.to_sym
        end
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

      def browser=(*args)
        @@browser = block_given? ? yield(args) : args.first
      end

      def browser
        @@browser || (WatirSession.browser if defined? WatirSession)
      end

    end

    def browser
      self.class.browser
    end

    def fill_form(model)
      model = model.to_h unless model.is_a? Hash
      intersect = self.class.element_list & model.keys
      intersect.each do |val|
        self.send("#{val}=", model[val])
      end
    end
    alias_method :populate_page_with, :fill_form

    def title
      browser.title
    end

    def url
      browser.url
    end

  end
end
