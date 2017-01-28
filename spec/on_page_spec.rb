require 'spec_helper'

class GoogleRequired < WatirDrops::PageObject
  page_url(required: true) { 'https://www.google.ca/?gws_rd=ssl' }
  page_title(required: true) { 'Google' }
  element(:search, required: true) { browser.text_field(id: 'lst-ib') }
end


class GoogleNotRequired < WatirDrops::PageObject
  page_url { 'https://www.google.ca' }
  page_title { 'Google_xxx' }
  element(:search) { browser.text_field(id: 'lst-ib_xxx') }
end

class GoogleRequiredNotMatch < WatirDrops::PageObject
  page_url(required: true) { 'https://www.google.ca/' }
  page_title(required: true) { 'Google_xxx' }
  element(:search, required: true) { browser.text_field(id: 'lst-ib_xxx') }
end



describe 'Page Object with on_page?' do
  let(:google_required) { GoogleRequired.visit }
  let(:google_not_required) { GoogleNotRequired.visit }
  let(:google_required_not_match) { GoogleRequiredNotMatch.visit }


  it 'will verify url if required' do
    expect(google_required).to be_a WatirDrops::PageObject
    expect(google_required.page_url).to eql 'https://www.google.ca/?gws_rd=ssl'
  end


  it 'will verify title if required' do
    expect(google_required).to be_a WatirDrops::PageObject
    expect(google_required.title).to eql 'Google'
  end

  it 'will verify required element' do
    expect(google_required).to be_a WatirDrops::PageObject
    expect(google_required.element).to be_present
  end

  it 'will not verify url if not required' do
    expect(google_not_required).to be_a WatirDrops::PageObject
    expect(google_not_required.page_url).not_to eql 'https://www.google.ca/?gws_rd=ssl'
  end
  #
  it 'will not verify title if not required' do
    expect(google_not_required).to be_a WatirDrops::PageObject
    expect(google_not_required.page_title).not_to eql 'Google'
  end

  it 'will not verify element if not required' do
    expect(google_not_required).to be_a WatirDrops::PageObject
    expect(google_not_required.search).not_to be_present
  end

  it 'will raise exception if required url does not match' do
    expect{ google_required_not_match}.to raise_error(Watir::Exception::Error)
  end

  it 'will raise exception if required title does not match' do
    expect{ google_required_not_match}.to raise_error(Watir::Exception::Error)
  end

  it 'will raise exception if required element is not present' do
    expect{ google_required_not_match}.to raise_error(Watir::Exception::Error)
  end

end
