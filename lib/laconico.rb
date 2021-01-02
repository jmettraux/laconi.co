
require 'redcarpet'


Dir[File.join(__dir__, '*.rb')]
  .each do |pa|
    require(pa) unless pa.match(/laconico\.rb$/)
  end

def neutralize_name(s); s.gsub(/[^a-zA-Z]/, '_'); end

