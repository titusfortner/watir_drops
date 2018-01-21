require 'watirspec'
require 'spec_helper'

WatirSpec.htmls << File.expand_path("../watirspec/html", __FILE__)

WatirSpec.implementation do |watirspec|
  opts = {}

  watirspec.name = :watir_drops
  watirspec.browser_class = Watir::Browser
  watirspec.browser_args = [:chrome, opts]

end

WatirSpec.run!
