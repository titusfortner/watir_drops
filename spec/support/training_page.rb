require_relative '../../lib/watir_drops/training_wheels'

class TrainingPage < WatirDrops::TrainingWheels
  page_url { 'http://bit.ly/watir-webdriver-demo' }

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
end

class ResultPage < WatirDrops::PageObject

  element(:message) { browser.div(css: '.ss-resp-message') }

end
