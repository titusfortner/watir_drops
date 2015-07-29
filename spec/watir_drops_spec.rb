require 'spec_helper'

describe WatirDrops do
  after(:all) do
    WatirDrops::Session.instance.quit
  end

  it 'starts browser' do
    browser = PageObject.new.browser
    expect(browser).to exist
  end
end
