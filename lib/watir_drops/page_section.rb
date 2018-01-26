module WatirDrops
  class PageSection
    extend WatirDrops::ElementHandling
    include WatirDrops::SectionHandling

    def initialize(el, obj = nil)
      @el = el
      msg = "#{el} must be a Watir::Element or a Watir::ElementCollection"
      raise ArgumentError, msg unless el.is_a?(Watir::Element) || el.is_a?(Watir::ElementCollection)
      @base = if obj.nil?
                el.is_a?(Watir::Element) ? el : el.first
              else
                els = el.is_a?(Watir::Element) ? to_collection(el) : el
                els.find { |el| @base = el; match?(obj) }
              end
    end

    def browser
      base.browser
    end

    def base
      return @base if @base
      raise Watir::Exception::UnknownObjectException, "Unable to locate Page Section with #{@el.inspect}"
    end

    def exist?
      !@base.nil?
    end
  end
end
