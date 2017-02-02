require 'spec_helper'
Watir.default_timeout = 5

class URLRequired < WatirDrops::PageObject
  page_url(required: true) { 'https://www.google.com/?gws_rd=ssl' }
end

class TitleRequired < WatirDrops::PageObject
  page_url { 'https://www.google.com/?gws_rd=ssl' }
  page_title { 'Google' }
end

class ElementsRequired < WatirDrops::PageObject
  page_url { 'https://www.google.com/?gws_rd=ssl' }
  element(:search, required: true) { browser.text_field(id: 'lst-ib') }
end

class NoneRequired < WatirDrops::PageObject
  page_url { 'https://www.example.com' }
  element(:search) { browser.text_field(id: 'lst-ib') }
end

module WatirDrops
  describe 'PageObject#on_page?' do
    before(:all) do
      @original_timeout = Watir.default_timeout
      Watir.default_timeout = 0
    end

    after(:all) { Watir.default_timeout = @original_timeout}

    context 'when url required' do
      it 'returns true on correct page after visit' do
        url_required = URLRequired.visit
        expect(url_required).to be_on_page
      end

      it 'returns true on correct page without visit call' do
        @browser.goto 'https://www.google.com/?gws_rd=ssl'
        expect(URLRequired.new).to be_on_page
      end

      it 'returns false on incorrect page' do
        NoneRequired.visit
        url_required = URLRequired.new
        expect(url_required).not_to be_on_page
      end

      it 'raises exception with an incorrect visit' do
        NoneRequired.visit
        allow_any_instance_of(URLRequired).to receive(:goto).and_return(nil)

        exception = Selenium::WebDriver::Error::WebDriverError
        message = 'Expected to be on URLRequired, but conditions not met'
        expect { URLRequired.visit }.to raise_exception(exception, message)
      end
    end

    context 'when title required' do
      it 'returns true on correct title' do
        title_required = TitleRequired.visit
        expect(title_required).to be_on_page
      end

      it 'returns false on incorrect title' do
        NoneRequired.visit
        title_required = TitleRequired.new
        expect(title_required).not_to be_on_page
      end
    end

    context 'when elements required' do
      it 'returns true on correct elements' do
        elements_required = ElementsRequired.visit
        expect(elements_required).to be_on_page
      end

      it 'returns false on incorrect elements' do
        NoneRequired.visit
        elements_required = ElementsRequired.new
        expect(elements_required).not_to be_on_page
      end
    end

    context 'when nothing is required' do
      it 'raises exception' do
        none_required = NoneRequired.visit
        exception = Selenium::WebDriver::Error::WebDriverError
        message = 'Can not verify page without any requirements set'
        expect { none_required.on_page? }.to raise_exception(exception, message)
      end
    end
  end
end