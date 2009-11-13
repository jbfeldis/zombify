require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('zombify', '0.1.0') do |p|
  p.description    = "Zombifies strings in your application."
  p.url            = "http://github.com/romaind/zombify"
  p.author         = "Studio Melipone"
  p.email          = "contact@studiomelipone.eu"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }