require 'watir_model'
require 'factory_girl'

class TestWatirModel < WatirModel
  key(:first_name, aliases: [:first]) { Faker::Name.first_name }
  key(:last_name) { Faker::Name.last_name }
  key(:email_address) { Faker::Internet.email }
  key(:email_address_confirm) { email_address }
  key(:country) { 'Sweden' }
  key(:occupation) { Faker::Job.title }
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
