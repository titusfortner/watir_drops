require 'watirspec_helper'

describe 'Collection Page' do

  describe "finds address" do
    it 'with WatirModel' do
      address = AddressModel.new(attributes_for :f_b_model)
      expect(CollectionPage.visit.address?(address)).to eq true
    end

    it 'with FactoryBot' do
      hash = attributes_for :f_b_model
      expect(CollectionPage.visit.address?(hash)).to eq true
    end

    it 'with OpenStruct' do
      hash = attributes_for :f_b_model
      open_struct = OpenStruct.new(hash)
      expect(CollectionPage.visit.address?(open_struct)).to eq true
    end

    it 'with DataMagic' do
      DataMagic.yml_directory = 'spec'
      DataMagic.load('support/dm.yml')
      dm = data_for(:dmagic)
      expect(CollectionPage.visit.address?(dm)).to eq true
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
