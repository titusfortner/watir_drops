class TestPage < WatirDrops::PageObject

  element(:form) { browser.form }
  element(:name) { browser.text_field(id: 'entry_1000000') }
  element(:language) { browser.select_list(id: 'entry_1000001') }
  element(:identity) { browser.radio(value: 'Both') }
  element(:version) { browser.checkbox(value: '1.9.2') }
  element(:save_button) { form.button(name: 'submit') }
  element(:required_message) { browser.div(class: 'required-message') }

  page_url { 'http://bit.ly/watir-webdriver-demo' }

  def error_message?
    required_messages.any?(&:present?)
  end
end

class ResultPage < WatirDrops::PageObject

  element(:message) { browser.div(css: '.ss-resp-message') }

end
