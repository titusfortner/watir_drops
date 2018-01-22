require 'watir_model'
require 'uri'

class AddressModel < WatirModel
  key(:first_name) { Faker::Name.first_name }
  key(:last_name) { Faker::Name.last_name }
  key(:street_address) { Faker::Address.street_address }
  key(:secondary_address) { Faker::Address.secondary_address }
  key(:city) { Faker::Address.city }
  key(:zip_code) { Faker::Address.zip_code }
  key(:country) { 'United States' }
  key(:state) { Faker::Address.state }

  key(:birthday, data_type: Date) { Date.parse "1990-07-14" }
  key(:age, data_type: Integer) { rand(100) }
  key(:website, data_type: URI) { Faker::Internet.url }
  key(:phone) { Faker::PhoneNumber.phone_number }
  key(:common_interests) { ['Climbing', 'Reading'] }
  key(:note) { Faker::Lorem.paragraph }

  def self.convert_to_uri(data)
    URI.parse data
  end

  def convert_from_uri(data)
    data.to_s
  end

end
