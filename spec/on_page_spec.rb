require 'spec_helper'

class TestPageUrl < WatirDrops::PageObject
  page_url(required: true) { 'https://www.google.ca/?gws_rd=ssl'}
  element(:search) { browser.text_field(id: 'lst-ib') }
end

class TestPageTitle < WatirDrops::PageObject
  page_url(required: true) { 'https://www.google.ca/?gws_rd=ssl'}
  page_title { 'Google' }
end


class TestPageElement < WatirDrops::PageObject
  page_url(required: true) { 'https://www.google.ca/?gws_rd=ssl'}
  element(:search, required: true) { browser.text_field(id: 'lst-ib') }
end


describe 'On Page' do

  it 'will verify url if required' do
    page = TestPageUrl.visit
    expect(page.page_url).to be == 'https://www.google.ca/?gws_rd=ssl'
  end

  it 'will verify title if defined' do
    page = TestPageTitle.visit
    expect(page.page_title).to be == 'Google'
  end

  it 'will verify required element' do
    page = TestPageElement.visit
    expect(page.search).to be_present
  end

end
