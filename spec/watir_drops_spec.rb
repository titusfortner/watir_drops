require 'spec_helper'

describe WatirDrops do

  it 'initializes with WatirSession' do
    require 'watir_session'
    @browser.quit
    WatirDrops::PageObject.browser = nil
    @browser = WatirSession.before_each
    expect(@browser).to be_a Watir::Browser
    expect(WatirDrops::PageObject.browser).to be == @browser
  end

  it 'navigates to a simple url' do
    test_page = TestPage.visit
    expect(test_page.title).to eql 'Watir-WebDriver Demo'
  end

  it 'navigates to a dynamic url' do
    class TestPage2 < WatirDrops::PageObject
      page_url { |val| "http://bit.ly/#{val}" }
    end

    TestPage2.visit('watir-webdriver-demo')
    expect(@browser.title).to eql 'Watir-WebDriver Demo'
  end

  it 'enters text into a textfield based on value it is set equal to' do
    TestPage.visit.name = 'Roger'
    expect(TestPage.use.name.value).to be == 'Roger'
  end

  it 'selects value from dropdown based on value it is set equal to' do
    TestPage.visit.language = 'Ruby'
    expect(TestPage.use.language.value).to be == 'Ruby'
  end

  it 'selects radio button based being set equal to a true value' do
    TestPage.visit.identity = true
    expect(TestPage.use.identity).to be_set
  end

  it 'selects checkbox based on being set equal to a true value' do
    TestPage.visit.version = true
    expect(TestPage.use.version).to be_set
  end

  it 'deselects checkbox based on being set equal to a true value' do
    TestPage.visit.version = true
    TestPage.use.version = false
    expect(TestPage.use.version).to_not be_set
  end

  it 'clicks button based on being set equal to a true value' do
    expect(TestPage.visit.required_message).to_not be_present
    expect(TestPage.use.error_message?).to be false
    TestPage.use.save_button = true
    expect(TestPage.use.error_message?).to be true
  end

end
