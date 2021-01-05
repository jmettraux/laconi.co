
require 'time'
require 'json'
require 'open-uri'


HOSTS =
  Hash.new do |h, k|
    s = `dig -x #{k}`
    m = s.match(/PTR[ \t]+([^ ]+)\./)
    h[k] = m[1] rescue '???'
  end
CITIES =
  Hash.new do |h, k|
    s = URI.open("https://freegeoip.app/json/#{k}").read
    h[k] = JSON.parse(s) rescue { 'country_code' => '?', 'city' => '?' }
  end


CR = "[0;0m"
CG = "[32m"
CY = "[33m"
CB = "[1m" # bright


STDIN.each_line do |l|

  l = l.strip

  m = l.match(/^[^ ]+ ([^ ]+) /)

  unless m
    puts if l == ''
    next
  end # so that I can hit Enter to space output...

  a = HOSTS[m[1]]
  c = CITIES[m[1]]; co = c['country_code']; re = c['region_code']; ci = c['city']

  l = l.gsub(/\[[^\]]+\]/) { |x|
    '[' + Time.parse(x[1..-2].sub(':', ' ')).localtime.to_s + ']' }
  l = l
    .gsub(/" (\d{3}) (\d)/) { |x| "\" #{CG}#{x[2, 3]}#{CR} #{x[-2..-1]}" }
    .gsub(/"(GET|HEAD) [^\s]+ HTTP\/[^"]+"/) { |x| "#{CY}#{x}#{CR}" }

  print "#{CB}#{a} #{ci}|#{re}|#{co}#{CR} #{l.split(/\s+/)[1..-1].join(' ')}\n\r"
end

