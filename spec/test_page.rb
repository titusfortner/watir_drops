class TestPage < WatirDrops::PageObject

  element(:name) {browser.text_field(id: 'entry_1000000')}
  element(:language) { browser.select_list(id: 'entry_1000001') }
  element(:save_button) { browser.button(name: 'submit') }

  page_url 'http://bit.ly/watir-webdriver-demo'

  def submit_form(opt={})
    self.name = opt.fetch(:name, 'Default Name')
    self.language = opt.fetch(:language, 'Python')
    save_button.click
  end
end

class ResultPage < WatirDrops::PageObject

  element(:message_text) { browser.div(css: '.ss-resp-message') }

  def message
    message_text.when_present.text
  end
end