require 'watir_model'
require 'factory_girl'

class TestWatirModel < WatirModel
  key(:name) { 'Roger' }
  key(:language) { 'Ruby' }
  key(:identity) { true }
  key(:version) { true }
  key(:save_button) { true }
end

class FGModel
  attr_accessor :name, :language, :identity, :version, :save_button
end

FactoryGirl.define do

  factory :f_g_model do
    name "Roger"
    language  "Ruby"
    identity true
    version true
    save_button true
  end

end
