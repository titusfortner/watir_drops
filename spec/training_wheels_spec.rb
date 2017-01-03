require 'spec_helper'
require_relative 'support/training_page'

describe WatirDrops::TrainingWheels do
  it 'raises an error when both locator and block are provided' do
    page = TrainingPage.visit
    expect { page.will_not_work }.to raise_error(StandardError, 'Can not define element with both locator and block')
  end

  context 'without locator or block' do
    it 'finds first link element' do
      first_link = TrainingPage.visit.first_link
      expect(first_link).to be_a Watir::Anchor
      expect(first_link.href).to be == 'https://www.google.com/forms/about/?utm_source=product&utm_medium=forms_logo&utm_campaign=forms'
    end

    it 'finds collection of elements' do
      all_links = TrainingPage.visit.all_links
      expect(all_links).to be_a Watir::AnchorCollection
      expect(all_links.size).to be == 4
      expect(all_links.all? { |link| link.is_a? Watir::Anchor }).to be true
    end
  end

  context 'with locator' do
    it 'finds a generic element' do
      element = TrainingPage.visit.first_element
      expect(element).to be_a Watir::Element
      expect(element.text).to start_with('Watir-WebDriver Demo')
    end

    it 'finds a collection of generic elements' do
      elements = TrainingPage.visit.all_elements
      expect(elements).to be_a Watir::ElementCollection
      expect(elements.size).to be == 75
      expect(elements.all? { |el| el.is_a? Watir::Element }).to be true
    end

    it 'finds a subclassed element' do
      first_input = TrainingPage.visit.first_input
      expect(first_input).to be_a Watir::Input
      expect(first_input.name).to be == 'entry.1000000'
    end

    it 'finds a collection of subclassed elements' do
      all_inputs = TrainingPage.visit.all_inputs
      expect(all_inputs).to be_a Watir::InputCollection
      expect(all_inputs.size).to be == 7
      expect(all_inputs.all? { |input| input.is_a? Watir::Input }).to be true
    end

  end

  context 'with block' do
    context 'with browser context' do
      it 'finds a generic element' do
        element = TrainingPage.visit.first_element
        expect(element).to be_a Watir::Element
        expect(element.text).to start_with('Watir-WebDriver Demo')
      end

      it 'finds an element collection' do
        elements = TrainingPage.visit.all_elements_block
        expect(elements).to be_a Watir::ElementCollection
        expect(elements.size).to be == 75
        expect(elements.all? { |div| div.is_a? Watir::Element }).to be true
      end
    end

    context 'with a nested element context' do
      it 'finds a generic element' do
        element = TrainingPage.visit.first_sub_element
        expect(element).to be_a Watir::Element
        expect(element.text).to start_with('Watir-WebDriver Demo')
      end

      it 'finds an element collection' do
        elements = TrainingPage.visit.all_sub_elements
        expect(elements).to be_a Watir::ElementCollection
        expect(elements.size).to be == 74
        expect(elements.all? { |div| div.is_a? Watir::Element }).to be true
      end
    end

    it 'raises an error if element found does not match type defined' do
      test_page = TrainingPage.visit
      expect { test_page.does_not_match }.to raise_error StandardError, /method was defined as a/
    end

    it 'finds an element with arguments passed in at runtime' do
      test_page = TrainingPage.visit
      expect(test_page.div_index(1) == test_page.div_index(1)).to be true
      expect(test_page.div_index(1) == test_page.div_index(2)).to be false
    end
  end
end
