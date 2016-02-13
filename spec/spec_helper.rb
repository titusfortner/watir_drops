require 'watir_drops'

require_relative 'test_page'
require_relative 'ruby_model'

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before(:each) do
    @browser = Watir::Browser.new :chrome
    WatirDrops::PageObject.browser = @browser
  end

  config.after(:each) do
    @browser.quit
  end
end
