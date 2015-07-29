require 'singleton'

module WatirDrops
  class Session
    include Singleton

    def browser
      @browser ||= Watir::Browser.new :chrome
    end

    def quit
      @browser.quit
      @browser = nil
    end

  end
end
