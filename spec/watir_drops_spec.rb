require 'spec_helper'

describe WatirDrops do
  after(:all) do
    WatirDrops::Session.instance.quit
  end

  it 'starts browser' do
    browser = PageObject.new.browser
    expect(browser).to exist
  end

  it 'navigates' do
    test_page = TestPage.new
    test_page.goto
    expect(test_page.title).to eql "Watir-WebDriver Demo"
  end

  it 'finds elements' do
    test_page = TestPage.new
    test_page.goto
    expect(test_page.name).to exist
  end

  it 'fills out form default' do
    TestPage.new.visit.submit_form

    expect(ResultPage.new.message).to include('Thank you')
  end


end
