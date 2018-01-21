require 'watirspec_helper'

describe 'Automatic Form Filling' do

  describe "accepts" do
    it 'WatirModel' do
      address = AddressModel.new
      SimpleForm.visit.submit_form(address)
      submitted_data = URI.decode(browser.url)[/[^\?]+$/].split('&').map { |p| p[/[^=]+$/] }#.reject { |d| d.nil? }
      expect(submitted_data.size).to eq 19
    end

    it 'FactoryBot' do
      hash = attributes_for :f_b_model
      SimpleForm.visit.submit_form hash
      submitted_data = URI.decode(browser.url)[/[^\?]+$/].split('&').map { |p| p[/[^=]+$/] }.reject { |d| d.nil? }
      expect(submitted_data.size).to eq 19
    end

    it 'OpenStruct' do
      hash = attributes_for :f_b_model
      open_struct = OpenStruct.new(hash)
      SimpleForm.visit.submit_form(open_struct)
      submitted_data = URI.decode(browser.url)[/[^\?]+$/].split('&').map { |p| p[/[^=]+$/] }.reject { |d| d.nil? }
      expect(submitted_data.size).to eq 19
    end

    it 'DataMagic' do
      DataMagic.yml_directory = 'spec'
      DataMagic.load('support/dm.yml')

      SimpleForm.visit.submit_form(data_for(:dmagic))
      submitted_data = URI.decode(browser.url)[/[^\?]+$/].split('&').map { |p| p[/[^=]+$/] }.reject { |d| d.nil? }
      expect(submitted_data.size).to eq 19
    end
  end

  describe "validate input" do
    let(:address) { AddressModel.new }

    it 'for text_field' do
      SimpleForm.visit.first_name = address.first_name
      expect(SimpleForm.new.first_name.value).to eq address.first_name
    end

    it 'for select_list' do
      SimpleForm.visit.state = address.state.to_s
      expect(SimpleForm.new.state.text).to eq address.state
    end

    it 'for radio sets' do
      country = address.country.to_s
      SimpleForm.visit.country = country
      expect(SimpleForm.new.country.selected?(country)).to eq true
    end

    it 'for radio' do
      SimpleForm.visit.radio_star = true
      expect(SimpleForm.new.radio_star).to be_set
    end

    it 'for date field' do
      SimpleForm.visit.birthday = address.birthday
      expect(Date.parse SimpleForm.new.birthday.value).to eq address.birthday
    end

    it 'for checkbox when positive' do
      SimpleForm.visit.check_it = true
      expect(SimpleForm.new.check_it).to be_set
    end

    it 'for checkbox when negative' do
      SimpleForm.visit.check_it = true
      SimpleForm.visit.check_it = false
      expect(SimpleForm.new.check_it).to_not be_set
    end

    it 'for checkboxes' do
      SimpleForm.visit.common_interests = address.common_interests
      expect(SimpleForm.new.common_interests.map(&:set?)).to eq [true, false, true]
    end

    it 'for textarea' do
      SimpleForm.visit.note = address.note
      expect(SimpleForm.new.note.value).to eq address.note
    end

    it 'for button when positive' do
      SimpleForm.visit.submit = true
      expect(browser.url).to include("?address%5Bfirst_name")
    end

    it 'for button when negative' do
      SimpleForm.visit.submit = false
      expect(browser.url).to_not include("?address%5Bfirst_name")
    end
  end

end
