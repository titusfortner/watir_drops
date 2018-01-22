require 'watigiri'

module WatirDrops
  module ElementValidation

    module ClassMethods
      def element(name, required: false, &block)
        super
        define_method("#{name}!") do |val = nil|
          watir_element = self.instance_exec &block
          case watir_element
          when Watir::Radio, Watir::CheckBox
            watir_element.set?
          when Watir::Select, Watir::RadioSet
            watir_element.selected? val
          when Watir::TextField, Watir::TextArea
            watir_element.value
          else
            watir_element.text!
          end
        end
      end
    end

    module InstanceMethods
      def valid?(obj)
        hash = obj.to_h
        intersect = self.class.element_list & hash.keys

        intersect.all? do |key|
          value_found = self.send("#{key}!", hash[key])
          value = obj.class.respond_to?(:convert_type) ? obj.class.convert_type(key, value_found) : value_found
          value == hash[key]
        end
      end
      alias_method :match?, :valid?

      def build(klass)
        intersect = self.class.element_list & klass.keys

        klass.convert intersect.each_with_object({}) do |key, hash|
          hash[key] = self.send("#{key}!")
        end
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.include InstanceMethods
    end
  end
end
