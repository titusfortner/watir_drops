module WatirDrops
  class PageSection
    extend WatirDrops::ElementHandling

    def initialize(el, obj = nil)
      @el = el
      msg = "#{el} must be a Watir::Element or a Watir::ElementCollection"
      raise ArgumentError, msg unless el.is_a?(Watir::Element) || el.is_a?(Watir::ElementCollection)
      @base = if obj.nil?
                el
              else
                els = el.is_a?(Watir::Element) ? to_collection(el) : el
                els.find { |el| @base = el; match?(obj) }
              end
    end

    def base
      return @base if @base
      raise Watir::Exception::UnknownObjectException, "Unable to locate Page Section with #{@el.inspect}"
    end

    def to_collection(el)
      Object.const_get("#{el.class}Collection").new(el.instance_variable_get('@query_scope'), el.selector)
    end

    def exist?
      !@base.nil?
    end

  end
end
