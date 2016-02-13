class TestPage < WatirDrops::PageObject

  element(:will_not_work, value: 'Both') { browser.element(value: 'both') }
  link(:does_not_match) { browser.div }

  link(:first_link)
  links(:all_links)

  element(:first_element, class: /ss-/)
  elements(:all_elements, class: /ss-/)

  input(:first_input, class: /ss-/)
  inputs(:all_inputs, class: /ss-/)

  element(:first_element_block) { browser.element(class: /ss-/) }
  elements(:all_elements_block) { browser.elements(class: /ss-/) }

  input(:first_input_block) { browser.input(class: /ss-/) }
  inputs(:all_inputs_block) { browser.inputs(class: /ss-/) }

  element(:first_sub_element) { first_element.element(class: /ss-/) }
  elements(:all_sub_elements) { first_element.elements(class: /ss-/) }

  input(:first_sub_input) { first_element.input(class: /ss-/) }
  inputs(:all_inputs_block) { first_element.inputs(class: /ss-/) }

  div(:div_index) { |indx| browser.div(class: /ss-/, index: indx) }

  form(:form)
  text_field(:name, id: 'entry_1000000')
  select_list(:language, id: 'entry_1000001')
  radio(:identity, value: 'Both')
  checkbox(:version, value: '1.9.2')
  button(:save_button, name: 'submit')
  div(:required_message, class: 'required-message')

  page_url { 'http://bit.ly/watir-webdriver-demo' }

  def error_message?
    required_messages.any?(&:present?)
  end
end

class ResultPage < WatirDrops::PageObject

  div(:message, css: '.ss-resp-message')

end
