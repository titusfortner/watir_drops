require 'watir_drops'
require_relative 'test_page'
require_relative 'ruby_model'

RSpec.configure do |config|
  WatirSession.start

  config.before(:each) do
    @browser = WatirSession.start_test
  end

  config.after(:each) do
    WatirSession.end_test
  end
end
