# HolidayCalendar

HolidayCalendar was built to find out which days
are national holidays. It was intended to use for Finnish
national holidays, but should be easy to customize.

It uses Google ical format calendars, and fetches 
calendar via http caching retrieved data.

Source code conforms to semantic versioning (http://semver.org/)

## Installation

Add this line to your application's Gemfile:

    gem 'holiday_calendar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install holiday_calendar

## Usage

    require 'holiday_calendar'

    c = HolidayCalendar::HolidayCalendar.new
    c.holiday?(Date.new(2013, 1, 1)) # => true

    Constructor supports two optional hash parameters:

    :cal_uri    - url to calendar to use, defaults to finnish calendar
    :cache_file - specify full path to the cache file

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
