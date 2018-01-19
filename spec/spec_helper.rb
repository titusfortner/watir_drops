require 'watir_drops'
require 'webdrivers'

require_relative 'support/test_page'
require_relative 'support/ruby_model'
require 'data_magic'

RSpec.configure do |config|

  config.include FactoryBot::Syntax::Methods
  config.include DataMagic

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    @browser = Watir::Browser.new :chrome
    WatirDrops::PageObject.browser = @browser
  end

  config.after(:each) do
    @browser.quit
  end
end
