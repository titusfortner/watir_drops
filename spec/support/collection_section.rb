class SubSection < WatirDrops::PageSection
  include WatirDrops::ElementValidation

  element(:he_man) { base.strong }
end

class AddressSection < WatirDrops::PageSection
  include WatirDrops::ElementValidation

  section(:spanner, SubSection) { base.span }

  element(:first_name) { base.span(data_test: 'first_name') }
  element(:last_name) { base.span(data_test: 'last_name') }
  element(:city) { base.span(data_test: 'city')}
  element(:state) { base.span(data_test: 'state') }
  element(:verify) { base.span(data_test: 'verify') }

  def associated_value
    verify.text
  end

end
