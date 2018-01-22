class CollectionPage < WatirDrops::PageObject
  include WatirDrops::ElementValidation

  elements(:address_list) { browser.lis }

  sections(:addresses, AddressSection) { browser.li }
  sections(:addresses2, AddressSection) { browser.lis }
  section(:address, AddressSection) { browser.lis }
  section(:address2, AddressSection) { address_list }
  section(:address3, AddressSection) { browser.li }

  element(:first_name) { |idx| browser.span(data_test: 'first_name', index: idx) }
  element(:last_name) { |idx| browser.span(data_test: 'last_name', index: idx) }
  element(:city) { |idx| browser.span(data_test: 'city', index: idx)}
  element(:state) { |idx| browser.span(data_test: 'state', index: idx) }
  element(:verify) { |idx| browser.span(data_test: 'verify', index: idx) }

  page_url { WatirSpec.url_for("collection_page.html") }

  def address?(address)
    !find_index(address).nil?
  end

  def associated_value(address)
    verify(find_index(address)).text
  end

  def find_index(address)
    hash = address.to_h
    address_list.to_a.each_with_index do |_addr, idx|
      next unless %i[first_name last_name city state].all? do |sym|
        send(sym, idx).text! == hash[sym]
      end
      return idx
    end
    nil
  end

end
