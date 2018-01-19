module WatirDrops
  module ElementHandling

    attr_writer :element_list
    attr_writer :required_element_list

    def element_list
      @element_list ||= []
    end

    def required_element_list
      @required_element_list ||= []
    end

    def inherited(subclass)
      subclass.element_list = element_list.dup
      subclass.required_element_list = required_element_list.dup
    end

    def elements(name, &block)
      define_method(name) do |*args|
        self.instance_exec(*args, &block)
      end

      element_list << name.to_sym
    end

    def element(name, required: false, &block)
      define_method(name) do |*args|
        self.instance_exec(*args, &block)
      end

      element_list << name.to_sym
      required_element_list << name.to_sym if required
    end

  end
end
