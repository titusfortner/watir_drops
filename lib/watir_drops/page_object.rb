module WatirDrops
  class PageObject
    extend WatirDrops::ElementHandling
    include Watir::Waitable

    class << self

      attr_writer :element_list
      attr_writer :required_element_list
      attr_reader :require_url

      def page_url(required: false)
        @require_url = required

        define_method("page_url") do |*args|
          yield(*args)
        end
      end

      def page_title
        define_method("page_title") do |*args|
          yield(*args)
        end
      end

      def visit(*args)
        new.tap do |page|
          page.goto(*args)
          exception = Selenium::WebDriver::Error::WebDriverError
          message = "Expected to be on #{page.class}, but conditions not met"
          if page.page_verifiable?
            begin
              page.wait_until(&:on_page?)
            rescue Watir::Wait::TimeoutError
              raise exception, message
            end
          end
        end
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

    def submit_form(model)
      fill_form(model)
      submit.click
    end

    def fill_form(obj)
      intersect = self.class.element_list & obj.to_h.keys

      intersect.each do |val|
        self.send("#{val}=", model[val])
      end
    end

    def inspect
      '#<%s url=%s title=%s>' % [self.class, url.inspect, title.inspect]
    end

    alias selector_string inspect


    def on_page?
      exception = Selenium::WebDriver::Error::WebDriverError
      message = "Can not verify page without any requirements set"
      raise exception, message unless page_verifiable?

      if self.class.require_url
        expected = page_url.gsub("#{URI.parse(page_url).scheme}://", '').chomp('/')
        actual = browser.url.gsub("#{URI.parse(browser.url).scheme}://", '').chomp('/')
        return false unless expected == actual
      end

      if self.respond_to?(:page_title) && browser.title != page_title
        return false
      end

      if !self.class.required_element_list.empty? && self.class.required_element_list.any? { |e| !send(e).present? }
        return false
      end

      true
    end

    def goto(*args)
      browser.goto page_url(*args)
    end

    def method_missing(method, *args, &block)
      if @browser.respond_to?(method) && method != :page_url
        @browser.send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, _include_all = false)
      @browser.respond_to?(method) || super
    end

    def page_verifiable?
      self.class.require_url || self.respond_to?(:page_title) || self.class.required_element_list.any?
    end
  end
end
