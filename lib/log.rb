
require 'time'
require 'json'
require 'yaml'
require 'open-uri'
require 'fileutils'

city_fn = 'tmp/cities.yaml'
city_yaml = YAML.load_file(city_fn) rescue {}

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
    .merge!(city_yaml)

out = []

STDIN.readlines.each do |l|
  l = l.strip
  m = l.match(/^[^ ]+ ([^ ]+) /)
  a = HOSTS[m[1]]
  c = CITIES[m[1]]; co = c['country_code']; re = c['region_code']; ci = c['city']
  l = l.gsub(/\[[^\]]+\]/) { |x|
    '[' + Time.parse(x[1..-2].sub(':', ' ')).localtime.to_s + ']' }
  out << "#{a} #{ci}|#{re}|#{co} #{l.split(/\s+/)[1..-1].join(' ')}"
end

sta = out[0].match(/\[(.+)\]/)[1].gsub(/[-:]/, '').gsub(/[^0-9]/, '_')[0, 13]
edn = out[-1].match(/\[(.+)\]/)[1].gsub(/[-:]/, '').gsub(/[^0-9]/, '_')[0, 13]

CITIES.values.each { |c| c['host'] = HOSTS[c['ip']] }

File.open(city_fn, 'wb') do |f|
  f.puts(YAML.dump(CITIES))
end
puts "#{CITIES.size} cities"
puts "#{HOSTS.size} hosts"

fn = "tmp/laconico__#{sta}__#{edn}.log"

File.open(fn, 'wb') do |f|
  out.each { |l| f.puts(l) }
end

Dir["tmp/laconico__#{sta}__*.log"].sort[0..-2].each do |pa|
  FileUtils.rm_f(pa)
  puts "remove #{pa}"
end

puts "#{File.exist?(fn) ? 'over' : ''}wrote #{fn}, #{out.size} requests"

