require 'active_support/inflector'

module WatirDrops
  class PageObject
    include Watir::Waitable

    class << self

      attr_writer :element_list

      def page_url
        define_method("page_url") do |*args|
          yield(*args)
        end

        define_method("goto") do |*args|
          browser.goto page_url(*args)
        end
      end

      def element_list
        @element_list ||= []
      end

      def inherited(subclass)
        subclass.element_list = element_list.dup
      end

      def elements(name, &block)
        define_method(name) do |*args|
          self.instance_exec(*args, &block)
        end

        element_list << name.to_sym
      end

      def element(name, &block)
        define_method(name) do |*args|
          self.instance_exec(*args, &block)
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
          when Watir::TextField, Watir::TextArea
            watir_element.wd.clear
            watir_element.send_keys val
          else
            watir_element.click if val
          end
        end

        element_list << name.to_sym
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

      def browser=(browser_input)
        @@browser = browser_input
      end

      def browser
        @@browser
      end

    end

    attr_reader :browser

    def initialize(browser_input = @@browser)
      @browser = browser_input
    end

    def fill_form(model)
      intersect = case model
                  when OpenStruct
                    self.class.element_list & model.to_h.keys
                  when Hash
                    self.class.element_list & model.keys
                  else
                    self.class.element_list & model.keys.select { |el| !model.send(el).nil? }
                  end
      intersect.each do |val|
        self.send("#{val}=", model[val])
      end
    end

    def inspect
      '#<%s url=%s title=%s>' % [self.class, url.inspect, title.inspect]
    end
    alias selector_string inspect

    def method_missing(method, *args, &block)
      if @browser.respond_to?(method)
        @browser.send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, _include_all = false)
      @browser.respond_to?(method) || super
    end

  end
end
