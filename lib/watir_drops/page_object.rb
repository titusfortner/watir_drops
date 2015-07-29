module WatirDrops
  class PageObject

    attr_reader :browser

    def initialize(browser=nil)
      @browser = browser || WatirDrops::Session.instance.browser
    end

  end
end
