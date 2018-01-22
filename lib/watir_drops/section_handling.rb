module WatirDrops
  module SectionHandling

    module ClassMethods
      def section(name, klass, &block)
        define_method(name) do |obj = nil|
          args = self.instance_exec obj, &block
          klass.new(*args)
        end
      end

      def sections(name, klass, &block)
        define_method(name) do
          arg = self.instance_exec &block
          elements = arg.is_a?(Watir::Element) ? to_collection(arg) : arg
          elements.map { |el| klass.new(el) }
        end
      end
    end

    module InstanceMethods
      def to_collection(el)
        Object.const_get("#{el.class}Collection").new(el.instance_variable_get('@query_scope'), el.selector)
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.include InstanceMethods
    end
  end
end
