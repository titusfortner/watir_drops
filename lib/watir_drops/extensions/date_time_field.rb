module Watir
  class DateTimeField < Input

    #
    # Selects this radio button.
    #

    def set!(date)
      message = "DateTimeField##{__method__} only accepts instances of DateTime or Time"
      raise ArgumentError, message unless [DateTime, ::Time].include?(date.class)

      date_time_string = date.strftime("%Y-%m-%dT%H:%M")
      element_call(:wait_for_writable) { execute_js(:setValue, @element, date_time_string) }
    end
    alias_method :set, :set!
    alias_method :value=, :set

    protected

  end # DateTimeField

  module Container
    def date_time_field(*args)
      DateTimeField.new(self, extract_selector(args).merge(tag_name: "input", type: "datetime-local"))
    end

    def date_time_fields(*args)
      DateTimeFieldCollection.new(self, extract_selector(args).merge(tag_name: "input", type: "datetime-local"))
    end
  end # Container

  class DateTimeFieldCollection < InputCollection
    private

    def element_class
      DateTimeField
    end
  end # DateTimeFieldCollection
end # Watir
