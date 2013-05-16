require "holiday_calendar/version"

require 'date'
require 'tmpdir'
require 'open-uri'
require 'digest'

require 'ri_cal'

module HolidayCalendar
  class HolidayCalendar
    DEFAULT_CAL_URI = 'https://www.google.com/calendar/ical/fi.finnish%23holiday%40group.v.calendar.google.com/public/basic.ics'
    CACHE_MAX_DAYS = 360

    def initialize(opts={})
      @opts = {}
      @holidays = nil
      @cal_uri = opts[:cal_uri] || DEFAULT_CAL_URI

      @calendar_cache = opts[:cache_file] || cache_path
    end

    def cache_path
      File.join(Dir.tmpdir, cache_basename)
    end

    def parse
      if needs_cache_refresh?(@calendar_cache)
        write_cache(@calendar_cache, read_calendar(@cal_uri))
      end

      @holidays = build_hash RiCal.parse(open(@calendar_cache))
    end

    # read calendar from uri. Can be local file or remote path
    def read_calendar(uri)
      File.read('resource/basic.ics')
    end

    def needs_cache_refresh?(fpath)
      !File.exist?(fpath) || cache_age_in_days(fpath) > CACHE_MAX_DAYS
    end

    def cache_age_in_days(fpath)
      (Time.now - File.mtime(fpath)) / 86400
    end

    # return hash keyed by holiday date object, with holiday name as value
    def holidays
      parse unless @holidays
      @holidays
    end

    def weekday?(date)
      !holiday?(date)
    end

    def holiday?(date)
      weekend?(date) || holidays.has_key?(date)
    end

    def weekend?(date)
      [0, 6].include?(date.wday)
    end

    def weekdays_between(d1, d2)
      sign_f = 1
      if d2 < d1
        d2, d1 = d1, d2
        sign_f = -1
      end

      sign_f * (d1+1..d2).inject(0) {|count, d| count += weekday?(d) ? 1 : 0 }
    end

    private

    def write_cache(fpath, content)
      STDERR.puts 'Creating cache'
      File.open(fpath, 'w') do |f|
        f.write content
      end
    end

    def cache_basename
      [Digest::MD5.hexdigest(@cal_uri), 'calendar_cache.ics'].join('-')
    end

    def build_hash(cal)
      cal.each_with_object({}) do |occ, days|
        occ.events.each do |evt|
          day = evt.dtstart
          days[day] = evt.summary
        end
      end
    end
  end
end

