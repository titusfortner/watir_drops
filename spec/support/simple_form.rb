class SimpleForm < WatirDrops::PageObject
  include WatirDrops::FormHandling

  element(:first_input) { browser.input }
  element(:nested_element) { browser.form(id: 'create_address').input }
  elements(:nested_elements) { browser.form(id: 'create_address').inputs }
  element(:accepts_value) { |idx| browser.input(index: idx) }
  element(:radio_star) { browser.radio(id: 'address_country_ca') }
  element(:check_it) { browser.checkbox(id: 'address_interest_dance') }


  element(:first_name) { browser.text_field(id: 'address_first_name') }
  element(:last_name) { browser.text_field(id: 'address_last_name') }
  element(:street_address) { browser.text_field(id: 'address_street_address') }
  element(:secondary_address) { browser.text_field(id: 'address_secondary_address') }
  element(:city) { browser.text_field(id: 'address_city') }
  element(:state) { browser.select(id: 'address_state') }
  element(:zip_code) { browser.text_field(id: 'address_zip_code') }
  element(:country) { browser.radio_set(name: 'address[country]') }

  element(:birthday) { browser.date_field(id: 'address_birthday') }
  element(:age) { browser.text_field(id: 'address_age') }
  element(:website) { browser.text_field(id: 'address_website') }
  element(:phone) { browser.text_field(id: 'address_phone') }
  elements(:common_interests) { browser.form(id: 'create_address').checkboxes }
  element(:note) { browser.textarea(id: 'address_note') }
  element(:submit) { browser.button(type: 'submit') }

  page_url { WatirSpec.url_for("simple_form.html") }

end
