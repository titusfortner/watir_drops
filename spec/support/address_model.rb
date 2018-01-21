require 'watir_model'
require 'carmen'
require 'uri'

class AddressModel < WatirModel
  key(:first_name) { Faker::Name.first_name }
  key(:last_name) { Faker::Name.last_name }
  key(:street_address) { Faker::Address.street_address }
  key(:secondary_address) { Faker::Address.secondary_address }
  key(:city) { Faker::Address.city }
  key(:zip_code) { Faker::Address.zip_code }
  key(:country, data_type: Carmen::Country) { 'United States' }
  key(:state, data_type: Carmen::Region) { st = Faker::Address.state; country.subregions.find { |sr| sr.to_s == st} }

  key(:birthday, data_type: Date) { Date.parse "1990-07-14" }
  key(:age, data_type: Integer) { rand(100) }
  key(:website, data_type: URI) { Faker::Internet.url }
  key(:phone) { Faker::PhoneNumber.phone_number }
  key(:common_interests) { ['Climbing', 'Reading'] }
  key(:note) { Faker::Lorem.paragraph }

  def self.convert_to_carmen_country(data)
    Carmen::Country.named data
  end

  def self.convert_to_uri(data)
    URI.parse data
  end

  def convert_from_carmen_country(data)
    data.to_s
  end

  def convert_from_carmen_region(data)
    data.to_s
  end

  def cpmvert_from_uri(data)
    data.to_s
  end

end
