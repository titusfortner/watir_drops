require 'watirspec_helper'

describe WatirDrops do

  it 'navigates to a simple url' do
    simple_form = SimpleForm.visit
    expect(simple_form.title).to eql 'Simple Form'
  end

  it 'navigates to a dynamic url' do
    class DynamicUrl < WatirDrops::PageObject
      page_url { |val| WatirSpec.url_for(val) }
    end

    DynamicUrl.visit('simple_form.html')
    expect(browser.title).to eql 'Simple Form'
  end

  it 'raises exception attempting to navigate to a Page without page_url set' do
    class NoUrl < WatirDrops::PageObject
    end

    begin
      NoUrl.visit
      fail "Expected exception not raised"
    rescue NoMethodError => ex
      expect(ex.message).to include "undefined method `page_url'"
    rescue
      fail "Expected exception not raised"
    end
  end

  describe '#selector_string' do
    it 'throws custom error message in waits' do
      simple_form = SimpleForm.visit

      message = /^timed out after 0\.5 seconds, waiting for true condition on #<SimpleForm url=\S+ title=/
      expect { simple_form.wait_until(timeout: 0.5) { false } }.to raise_exception Watir::Wait::TimeoutError, message
    end
  end
end
