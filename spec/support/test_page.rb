class TestPage < WatirDrops::PageObject

  element(:form) { browser.form }
  element(:name) { browser.text_field(id: 'entry_1000000') }
  element(:language) { browser.select_list(id: 'entry_1000001') }
  element(:identity) { browser.radio(value: 'Both') }
  element(:version) { browser.checkbox(value: '1.9.2') }
  element(:save_button) { form.button(name: 'submit') }
  elements(:required_messages) { browser.divs(class: 'required-message') }

  element(:div_index) { |indx| browser.div(class: /ss-/, index: indx) }
  element(:first_element) { browser.div(class: /ss-/) }
  elements(:all_elements) { browser.divs(class: /ss-/) }
  element(:first_sub_element) { first_element.div(class: /ss-/) }
  elements(:all_sub_elements) { first_element.divs(class: /ss-/) }

  page_url { 'http://bit.ly/watir-webdriver-demo' }

  def error_message?
    required_messages.to_a.any?(&:present?)
  end
end

class ResultPage < WatirDrops::PageObject

  element(:message) { browser.div(css: '.ss-resp-message') }

end
