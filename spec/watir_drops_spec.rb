require 'spec_helper'

describe WatirDrops do

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

  it 'raises exception attempting to navigate to a Page without page_url set' do
    begin
      ResultPage.visit
      fail "Expected exception not raised"
    rescue NoMethodError => ex
      expect(ex.message).to include "undefined method `page_url'"
    rescue
      fail "Expected exception not raised"
    end
  end

  it 'enters text into a textfield based on value it is set equal to' do
    TestPage.visit.name = 'Roger'
    expect(TestPage.new.name.value).to be == 'Roger'
  end

  it 'selects value from dropdown based on value it is set equal to' do
    TestPage.visit.language = 'Ruby'
    expect(TestPage.new.language.value).to be == 'Ruby'
  end

  it 'selects radio button based being set equal to a true value' do
    TestPage.visit.identity = true
    expect(TestPage.new.identity).to be_set
  end

  it 'selects checkbox based on being set equal to a true value' do
    TestPage.visit.version = true
    expect(TestPage.new.version).to be_set
  end

  it 'deselects checkbox based on being set equal to a true value' do
    TestPage.visit.version = true
    TestPage.new.version = false
    expect(TestPage.new.version).to_not be_set
  end

  it 'clicks button based on being set equal to a true value' do
    expect(TestPage.visit.error_message?).to be false
    TestPage.new.save_button = true
    expect(TestPage.new.error_message?).to be true
  end

  describe '#selector_string' do
    it 'throws custom error message in waits' do
      test_page = TestPage.visit

      message = /^timed out after 0\.5 seconds, waiting for true condition on #<TestPage url=\S+ title=/
      expect { test_page.wait_until(timeout: 0.5) { false } }.to raise_exception Watir::Wait::TimeoutError, message
    end
  end
end
