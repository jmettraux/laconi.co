
#
# Specifying laconi.co
#
# Fri Jan  1 17:35:14 JST 2021
#

require 'pp'

require 'laconico'


module Helpers
end # Helpers


RSpec.configure do |c|

  c.alias_example_to(:they)
  c.alias_example_to(:so)
  c.include(Helpers)
end

