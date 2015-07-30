class TestPage < WatirDrops::PageObject

  element(:name) { browser.text_field(id: 'entry_1000000') }

  page_url 'http://bit.ly/watir-webdriver-demo'

end
