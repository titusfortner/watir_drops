class ViewPage < WatirDrops::PageObject
  include WatirDrops::ElementValidation

  page_url { WatirSpec.url_for("display_page.html") }

  element(:first_name) { browser.span(data_test: 'first_name') }
  element(:last_name) { browser.span(data_test: 'last_name') }
  element(:street_address) { browser.span(data_test: 'street_address') }
  element(:secondary_address) { browser.span(data_test: 'secondary_address') }
  element(:city) { browser.span(data_test: 'city') }
  element(:state) { browser.span(data_test: 'state') }
  element(:zip_code) { browser.span(data_test: 'zip_code') }
  element(:country) { browser.span(data_test: 'country') }

  element(:birthday) { browser.span(data_test: 'birthday') }
  element(:age) { browser.span(data_test: 'age') }
  element(:website) { browser.span(data_test: 'website') }
  element(:phone) { browser.span(data_test: 'phone') }
  elements(:interests) { browser.span(data_test: /interest_/) }

  element(:note) { browser.span(data_test: 'note') }

end
