require 'factory_bot'

class FBModel
  attr_accessor :first_name, :last_name, :street_address, :secondary_address, :city, :state,
                :zip_code, :country, :birthday, :age, :website, :phone, :common_interests, :note
end

FactoryBot.define do
  factory :f_b_model do
    first_name "Grace"
    last_name "Weimann"
    street_address "604 Norma Stravenue"
    secondary_address "Apt. 662"
    city "Port Randy"
    state "South Carolina"
    zip_code "69345-5915"
    country "United States"
    birthday "1990-07-14"
    age "28"
    website "http://heidenreich.info/rosetta"
    phone "1-978-151-2805"
    common_interests ["Climbing", "Reading"]
    note "Recusandae repellat magnam. Consequuntur praesentium occaecati veritatis explicabo ab quis eius."
  end
end
