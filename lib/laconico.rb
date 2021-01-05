
require 'redcarpet'


Dir[File.join(__dir__, '*.rb')]
  .each do |pa|

    require(pa) \
      unless %w[ laconico.rb tail.rb log.rb ].find { |e| pa.end_with?(pa) }
  end

def neutralize_name(s); s.gsub(/[^a-zA-Z]/, '_'); end

