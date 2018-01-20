class TestPage < WatirDrops::PageObject
  include WatirDrops::FormHandling

  element(:first_name) { browser.text_field(id: 'new_user_first_name') }
  element(:last_name) { browser.text_field(id: 'new_user_last_name') }
  element(:email_address) { browser.text_field(id: 'new_user_email') }
  element(:email_address_confirm)  { browser.text_field(id: 'new_user_email_confirm') }
  element(:country) { browser.select(id: 'new_user_country')}
  element(:occupation) { browser.text_field(id: 'new_user_occupation') }
  element(:submit) { browser.button(id: 'new_user_submit') }

  element(:cars) { browser.checkbox(id: 'new_user_interests_cars')}
  element(:div_index) { |indx| browser.div(index: indx) }
  element(:first_element) { browser.div }
  elements(:all_elements) { browser.divs }
  element(:first_sub_element) { div_index(1).div }
  elements(:all_sub_elements) { div_index(1).divs }

  page_url { WatirSpec.url_for("forms_with_input_elements.html") }

end

class ResultPage < WatirDrops::PageObject

  element(:message) { browser.div(id: 'messages').div(index: -1) }

  def success?
    message.text == 'submit'
  end
end
