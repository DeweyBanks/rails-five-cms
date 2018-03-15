
Time::DATE_FORMATS.merge!(
  post_date: lambda { |time| time.strftime("%b #{time.day.ordinalize}, %Y") }
)
