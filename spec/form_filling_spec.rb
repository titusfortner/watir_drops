require 'spec_helper'

describe 'Automatic Form Filling' do

  it 'accepts WatirModel' do
    TestPage.visit.fill_form(TestWatirModel.new)
    expect(ResultPage.new.message.text).to include('Thank you')
  end

  it 'accepts FactoryGirl' do
    TestPage.visit.fill_form(attributes_for :f_g_model)
    expect(ResultPage.new.message.text).to include('Thank you')
  end

  it 'accepts Hash' do
    TestPage.visit.fill_form(name: 'Roger',
                             language: 'Ruby',
                             identity: true,
                             version: true,
                             save_button: true)
    expect(ResultPage.new.message.text).to include('Thank you')
  end

  it 'accepts OpenStruct' do
    open_struct = OpenStruct.new(name: 'Roger',
                                 language: 'Ruby',
                                 identity: true,
                                 version: true,
                                 save_button: true)
    TestPage.visit.fill_form(open_struct)
    expect(ResultPage.new.message.text).to include('Thank you')
  end

  it 'accepts DataMagic' do
    DataMagic.yml_directory = 'spec'
    DataMagic.load('support/dm.yml')

    TestPage.visit.fill_form(data_for(:dmagic))
    expect(ResultPage.new.message.text).to include('Thank you')
  end

end
