
require 'redcarpet'


Dir[File.join(__dir__, '*.rb')]
  .each do |pa|
    require(pa) unless pa.match(/laconico\.rb$/)
  end

