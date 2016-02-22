module WatirDrops

  class TrainingWheels < PageObject

    class << self

      Watir::Container.instance_methods(false).each do |class_method_name|
        next if class_method_name == :use
        define_method(class_method_name) do |instance_method_name, locator = {}, &block|
          define_method(instance_method_name) do |*args|
            if block.is_a? Proc
              raise StandardError, 'Can not define element with both locator and block' unless locator.empty?
              expected_class = browser.send(class_method_name).class
              element = self.instance_exec(*args, &block)
              return element if element.is_a? expected_class
              raise StandardError, "#{instance_method_name} method was defined as a #{expected_class}, but is a #{element.class}"
            else
              browser.send(class_method_name, locator)
            end
          end

          define_method("#{instance_method_name}=") do |val|
            watir_element = self.send(instance_method_name)
            watir_element.wait_until_present
            case watir_element
            when Watir::Radio
              watir_element.set if val
            when Watir::CheckBox
              val ? watir_element.set : watir_element.clear
            when Watir::Select
              watir_element.select val
            when Watir::Button
              watir_element.click
              # TODO - Email & Password types are not set to UserEditable in Watir
            when Watir::Input
              watir_element.wd.clear
              watir_element.send_keys val
            else
              watir_element.click if val
            end
          end

          element_list << instance_method_name.to_sym
        end
      end
    end

    alias_method :populate_page_with, :fill_form

  end
end
