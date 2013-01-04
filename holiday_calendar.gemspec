# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'holiday_calendar/version'

Gem::Specification.new do |gem|
  gem.name          = "holiday_calendar"
  gem.version       = HolidayCalendar::VERSION
  gem.authors       = ["Edvard Majakari"]
  gem.email         = ["edvard@majakari.net"]
  gem.description   = %q{
    Holiday calendar for finding out annual holidays, defaults
    to Finnish calendar.

    Uses Google calendar service to find out holidays, caching the results
}
  gem.summary       = %q{Finnish holiday calendar for finding out annual holidays}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('ri_cal', '>= 0.8.8')
end
