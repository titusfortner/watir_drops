require 'watirspec_helper'

describe 'Element Validation' do

  describe "accepts" do
    it 'WatirModel' do
      address = AddressModel.new(attributes_for :f_b_model)
      expect(ViewPage.visit).to be_valid(address)
    end

    it 'FactoryBot' do
      hash = attributes_for :f_b_model
      expect(ViewPage.visit).to be_valid(hash)
    end

    it 'OpenStruct' do
      hash = attributes_for :f_b_model
      open_struct = OpenStruct.new(hash)
      expect(ViewPage.visit).to be_valid(open_struct)
    end

    it 'DataMagic' do
      DataMagic.yml_directory = 'spec'
      DataMagic.load('support/dm.yml')
      dm = data_for(:dmagic)
      expect(ViewPage.visit).to be_valid(dm)
    end
  end

  describe "validate text" do
    let(:address) { AddressModel.new(attributes_for :f_b_model) }

    it 'for text_field' do
      expect(ViewPage.visit.first_name!).to eq address.first_name
    end

  end

end
