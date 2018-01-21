require 'watirspec_helper'

describe 'Element Handling' do

    context 'with browser context' do
      it 'finds a generic element' do
        element = SimpleForm.visit.first_input
        expect(element).to be_a Watir::Element
        expect(element.id).to eq 'address_first_name'
      end

      it 'finds an element collection' do
        elements = SimpleForm.visit.common_interests
        expect(elements).to be_a Watir::CheckBoxCollection
        expect(elements.size).to be == 3
      end
    end

    context 'with a nested element context' do
      it 'finds a generic element' do
        element = SimpleForm.visit.nested_element
        expect(element).to be_a Watir::Input
        expect(element.id).to be == 'address_first_name'
      end

      it 'finds an element collection' do
        elements = SimpleForm.visit.nested_elements
        expect(elements).to be_a Watir::InputCollection
        expect(elements.size).to eq 19
      end
    end

    it 'finds an element with arguments passed in at runtime' do
      simple_form = SimpleForm.visit
      expect(simple_form.accepts_value(2)).to be == browser.inputs[2]
    end

end
