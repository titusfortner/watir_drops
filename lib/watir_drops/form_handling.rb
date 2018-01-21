module WatirDrops
  module FormHandling

    module ClassMethods
      def element(name, required: false, &block)
        super
        define_method("#{name}=") do |val|
          watir_element = self.instance_exec &block
          case watir_element
          when Watir::RadioSet
            watir_element.select val
          when Watir::Radio
            watir_element.set if val
          when Watir::CheckBox
            val ? watir_element.set : watir_element.clear
          when Watir::Select
            watir_element.select val
          when Watir::Button
            watir_element.click if val
          when Watir::TextField, Watir::TextArea
            watir_element.set val if val
          when Watir::DateField, Watir::DateTimeField
            watir_element.set val
          else
            watir_element.click if val
          end
        end
      end

      def elements(name, &block)
        super
        define_method("#{name}=") do |val|
          collection = self.instance_exec &block
          super unless collection.is_a? Watir::CheckBoxCollection
          collection.each { |el| val.include?(el.label.text) ? el.set : el.clear }
        end
      end

    end

    module InstanceMethods
      def submit_form(model)
        fill_form(model)
        submit.click
      end

      def fill_form(obj)
        hash = obj.to_h
        intersect = self.class.element_list & hash.keys

        intersect.each do |val|
          self.send("#{val}=", hash[val])
        end
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.include InstanceMethods
    end

  end
end
