require 'watirspec_helper'

describe WatirDrops do

  it 'navigates to a simple url' do
    test_page = TestPage.visit
    expect(test_page.title).to eql 'Forms with input elements'
  end

  it 'navigates to a dynamic url' do
    class TestPage2 < WatirDrops::PageObject
      page_url { |val| WatirSpec.url_for(val) }
    end

    TestPage2.visit('forms_with_input_elements.html')
    expect(browser.title).to eql 'Forms with input elements'
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
    TestPage.visit.first_name = 'Roger'
    expect(TestPage.new.first_name.value).to be == 'Roger'
  end

  it 'selects value from dropdown based on value it is set equal to' do
    TestPage.visit.country = 'Sweden'
    expect(TestPage.new.country.value).to be == '3'
  end

  # Update Radio Set
  xit 'selects radio button based being set equal to a true value' do
    TestPage.visit.identity = true
    expect(TestPage.new.identity).to be_set
  end

  it 'selects checkbox based on being set equal to a true value' do
    TestPage.visit.cars = true
    expect(TestPage.new.cars).to be_set
  end

  it 'deselects checkbox based on being set equal to a true value' do
    TestPage.visit.cars = true
    TestPage.new.cars = false
    expect(TestPage.new.cars).to_not be_set
  end

  it 'clicks button based on being set equal to a true value' do
    TestPage.visit.submit = true
    expect(ResultPage.new.success?).to be true
  end

  describe '#selector_string' do
    it 'throws custom error message in waits' do
      test_page = TestPage.visit

      message = /^timed out after 0\.5 seconds, waiting for true condition on #<TestPage url=\S+ title=/
      expect { test_page.wait_until(timeout: 0.5) { false } }.to raise_exception Watir::Wait::TimeoutError, message
    end
  end
end
