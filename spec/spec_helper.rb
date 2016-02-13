require 'watir_drops'

require_relative 'test_page'
require_relative 'ruby_model'

RSpec.configure do |config|
  WatirSession.start

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before(:each) do
    WatirSession.before_each

    @browser = WatirSession.browser
  end

  config.after(:each) do
    WatirSession.after_each
  end
end
