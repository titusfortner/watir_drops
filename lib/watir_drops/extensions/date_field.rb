module Watir
  class DateField < Input

    #
    # Selects this radio button.
    #

    def set!(date)
      message = "DateField##{__method__} only accepts instances of Date"
      raise ArgumentError, message unless date.is_a? Date

      date_string = date.strftime("%Y-%m-%d")
      element_call(:wait_for_writable) { execute_js(:setValue, @element, date_string) }
    end
    alias_method :set, :set!
    alias_method :value=, :set

    protected

  end # DateField

  module Container
    def date_field(*args)
      DateField.new(self, extract_selector(args).merge(tag_name: "input", type: "date"))
    end

    def date_fields(*args)
      DateFieldCollection.new(self, extract_selector(args).merge(tag_name: "input", type: "date"))
    end
  end # Container

  class DateFieldCollection < InputCollection
    private

    def element_class
      DateField
    end
  end # DateFieldCollection
end # Watir
