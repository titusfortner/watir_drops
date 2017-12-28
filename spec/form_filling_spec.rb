require 'spec_helper'

class AliasTestPage < WatirDrops::PageObject
  element(:first) { browser.text_field(id: 'new_user_first_name') }
  element(:last_name) { browser.text_field(id: 'new_user_last_name') }
  element(:email_address) { browser.text_field(id: 'new_user_email') }
  element(:email_address_confirm)  { browser.text_field(id: 'new_user_email_confirm') }
  element(:country) { browser.select(id: 'new_user_country')}
  element(:occupation) { browser.text_field(id: 'new_user_occupation') }
  element(:submit) { browser.button(id: 'new_user_submit') }

  page_url { 'http://watir.com/examples/forms_with_input_elements.html' }
end

describe 'Automatic Form Filling' do

  it 'accepts WatirModel' do
    TestPage.visit.submit_form(TestWatirModel.new)
    expect(ResultPage.new.success?).to eq true
  end

  it 'uses aliases from WatirModel' do
    AliasTestPage.visit.submit_form(TestWatirModel.new)
    expect(ResultPage.new.success?).to eq true
  end

  it 'accepts FactoryGirl' do
    TestPage.visit.submit_form(attributes_for :f_g_model)
    expect(ResultPage.new.success?).to eq true
  end

  it 'accepts Hash' do
    TestPage.visit.submit_form(name: 'Roger',
                             language: 'Ruby',
                             identity: true,
                             version: true,
                             save_button: true)
    expect(ResultPage.new.success?).to eq true
  end

  it 'accepts OpenStruct' do
    open_struct = OpenStruct.new(name: 'Roger',
                                 language: 'Ruby',
                                 identity: true,
                                 version: true,
                                 save_button: true)
    TestPage.visit.submit_form(open_struct)
    expect(ResultPage.new.success?).to eq true
  end

  it 'accepts DataMagic' do
    DataMagic.yml_directory = 'spec'
    DataMagic.load('support/dm.yml')

    TestPage.visit.submit_form(data_for(:dmagic))
    expect(ResultPage.new.success?).to eq true
  end

end
