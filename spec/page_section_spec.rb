require 'watirspec_helper'

describe 'Page section' do

  context 'from Collection' do
    describe "finds address" do
      it 'with WatirModel' do
        address = AddressModel.new(attributes_for :f_b_model)
        addr = CollectionPage.visit.address(address)

        expect(addr.exist?).to eq true
        expect(addr.first_name.text).to eq address.first_name
      end

      it 'with FactoryBot' do
        hash = attributes_for :f_b_model
        addr = CollectionPage.visit.address(hash)

        expect(addr.exist?).to eq true
        expect(addr.first_name.text).to eq hash[:first_name]
      end

      it 'with OpenStruct' do
        hash = attributes_for :f_b_model
        addr = CollectionPage.visit.address(hash)

        expect(addr.exist?).to eq true
        expect(addr.first_name.text).to eq hash[:first_name]
      end

      it 'with DataMagic' do
        DataMagic.yml_directory = 'spec'
        DataMagic.load('support/dm.yml')
        dm = data_for(:dmagic)

        addr = CollectionPage.visit.address(dm)

        expect(addr.exist?).to eq true
        expect(addr.first_name.text).to eq dm[:first_name]
      end

      it 'when defined with existing element collection' do
        address = AddressModel.new(attributes_for :f_b_model)
        addr = CollectionPage.visit.address2(address)

        expect(addr.exist?).to eq true
        expect(addr.first_name.text).to eq address.first_name
      end

      it 'when defined with single element' do
        address = AddressModel.new(attributes_for :f_b_model)
        addr = CollectionPage.visit.address3(address)

        expect(addr.exist?).to eq true
        expect(addr.first_name.text).to eq address.first_name
      end

    end

    it "finds first section when no object is defined" do
      addr = CollectionPage.visit.address

      expect(addr.exist?).to eq true
      expect(addr.first_name.text).to eq "Aaron"
    end

    it "does not find address when not present" do
      address = AddressModel.new

      addr = CollectionPage.visit.address(address)

      expect(addr.exist?).to eq false
      msg = /Unable to locate Page Section with/
      expect { addr.first_name }.to raise_exception Watir::Exception::UnknownObjectException, msg
    end

    it "gets associated value" do
      address = AddressModel.new(attributes_for :f_b_model)
      expect(CollectionPage.visit.address(address).associated_value).to eq 'three'
    end

    it "gets index from collection" do
      as = CollectionPage.visit.addresses
      expect(as[2].associated_value).to eq 'three'
    end

    it "nests" do
      address = AddressModel.new(attributes_for :f_b_model)
      addr = CollectionPage.visit.address(address)
      spans = addr.spanner
      expect(spans.exist?).to eq true
      expect(spans.he_man.text).to eq "First name:"
    end

  end
end