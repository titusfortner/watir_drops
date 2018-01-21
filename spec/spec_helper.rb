require 'watir_drops'
require 'webdrivers'

require_relative 'support/simple_form'
require_relative 'support/view_page'
require_relative 'support/collection_page'
require_relative 'support/address_model'
require_relative 'support/address_fb'
require 'data_magic'

RSpec.configure do |config|

  config.include FactoryBot::Syntax::Methods
  config.include DataMagic

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    WatirDrops::PageObject.browser = browser
  end

end
