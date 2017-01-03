require 'spec_helper'

describe 'Element Location' do

  context 'with block' do
    context 'with browser context' do
      it 'finds a generic element' do
        element = TestPage.visit.first_element
        expect(element).to be_a Watir::Element
        expect(element.text).to start_with('Watir-WebDriver Demo')
      end

      it 'finds an element collection' do
        elements = TestPage.visit.all_elements
        expect(elements).to be_a Watir::ElementCollection
        expect(elements.size).to be == 38
        expect(elements.all? { |div| div.is_a? Watir::Element }).to be true
      end
    end

    context 'with a nested element context' do
      it 'finds a generic element' do
        element = TestPage.visit.first_sub_element
        expect(element).to be_a Watir::Element
        expect(element.attribute_value('class')).to be == 'ss-header-image-container'
      end

      it 'finds an element collection' do
        elements = TestPage.visit.all_sub_elements
        expect(elements).to be_a Watir::ElementCollection
        expect(elements.size).to be == 37
        expect(elements.all? { |div| div.is_a? Watir::Element }).to be true
      end
    end

    it 'finds an element with arguments passed in at runtime' do
      test_page = TestPage.visit
      expect(test_page.div_index(1) == test_page.div_index(1)).to be true
      expect(test_page.div_index(1) == test_page.div_index(2)).to be false
    end
  end

end
