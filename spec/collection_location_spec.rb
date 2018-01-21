require 'watirspec_helper'

describe 'Collection Page' do

  describe "finds index" do
    it 'WatirModel' do
      address = AddressModel.new(attributes_for :f_b_model)
      expect(CollectionPage.visit.find_index(address)).to eq 2
    end

    it 'FactoryBot' do
      hash = attributes_for :f_b_model
      expect(CollectionPage.visit.find_index(hash)).to eq 2
    end

    it 'OpenStruct' do
      hash = attributes_for :f_b_model
      open_struct = OpenStruct.new(hash)
      expect(CollectionPage.visit.find_index(open_struct)).to eq 2
    end

    it 'DataMagic' do
      DataMagic.yml_directory = 'spec'
      DataMagic.load('support/dm.yml')
      dm = data_for(:dmagic)
      expect(CollectionPage.visit.find_index(dm)).to eq 2
    end
  end

  it "does not find index when not present" do
    address = AddressModel.new
    expect(CollectionPage.visit.find_index(address)).to eq nil
  end

  it "gets associated value" do
    address = AddressModel.new(attributes_for :f_b_model)
    expect(CollectionPage.visit.associated_value(address)).to eq 'three'
  end

end
