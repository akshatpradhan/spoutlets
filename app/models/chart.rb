class Chart

  def build_chart(user, chart_type)
# https://github.com/michelson/lazy_high_charts/blob/master/lib/lazy_high_charts/high_chart.rb
# http://api.highcharts.com/highcharts
    @entries = user.entries
    ::LazyHighCharts::HighChart.new(random_canvas_id) do |chart|
      chart.options[:chart][:defaultSeriesType] = chart_type
      chart.options[:xAxis][:type] = 'datetime'
      chart.series(mood_information( :happiness_level))
      chart.series(mood_information(   :anxiety_level))
      chart.series(mood_information(:irritation_level))
    end
  end

  private

# Convert ActiveRecord timestamp to Javascript Date.UTC format
  def javascript_date_utc(timestamp)
# http://kevin.h-pk-ns.com/2011/09/01/ruby-datetime-to-javascript-date-conversion/
# http://www.w3schools.com/jsref/jsref_utc.asp
    milliseconds_per_second = 1000
    timestamp.tv_sec * milliseconds_per_second
  end

  def mood_information(field_name)
# http://api.highcharts.com/highcharts#series.data
    {
      :name => field_name.to_s,
      :data => mood_values(field_name),
    }
  end

  def mood_values(field_name)
# http://jsfiddle.net/gh/get/jquery/1.7.2/highslide-software/highcharts.com/tree/master/samples/highcharts/series/data-array-of-arrays-datetime/
    @entries.map do |entry|
      [
        javascript_date_utc(entry.created_at),
        entry.send(field_name),   # entry.happiness_level
      ]
    end
  end

  def random_canvas_id
# Don't use SecureRandom.urlsafe_base64; it gives invalid characters.
    ('a'..'z').to_a.shuffle.take(3).join
  end
end
