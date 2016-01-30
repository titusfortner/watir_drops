require 'watir_model'

class RubyModel < WatirModel
  key(:name) { 'Roger' }
  key(:language) { 'Ruby' }
  key(:identity) { true }
  key(:version) { true }
  key(:save_button) { true }
end
