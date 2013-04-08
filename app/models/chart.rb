class Chart

  def build_chart(user, chart_type)
    @entries = user.entries
    case chart_type
    when 'line'
      chart_basic_line
    when 'pie'
      chart_pie
    else
      raise
    end
  end

  private

  def chart_basic_line
# https://github.com/michelson/lazy_high_charts/blob/master/lib/lazy_high_charts/high_chart.rb
# http://api.highcharts.com/highcharts
# http://www.highcharts.com/demo/line-basic
    ::LazyHighCharts::HighChart.new(random_canvas_id) do |chart|
      chart.options[:chart][:defaultSeriesType] = 'line'
      chart.options[:xAxis][:minTickInterval] = seconds_in_a_day * milliseconds_per_second
      chart.options[:xAxis][:type] = 'datetime'
      chart.options[:yAxis][:gridLineWidth] = hide_lines
      chart.options[:yAxis][:max] = 5
      mood_field_names.each{|field_name| chart.series(mood_information_basic_line(field_name))}
    end
  end

  def chart_pie
# http://www.highcharts.com/demo/pie-basic
    @a_month_ago = javascript_date_utc(Time.now.months_ago(1))
    ::LazyHighCharts::HighChart.new(random_canvas_id) do |chart|
      chart.options[:chart][:defaultSeriesType] = 'pie'
##    chart.options[:chart][:plotBorderWidth] = 0  # Doesn't work.
##    chart.options[:chart][:plotShadow] = false   # Doesn't work.
      chart.options[:plotOptions][:pie] =
        {
          :allowPointSelect => false,
          :dataLabels =>
            {
              :connectorColor => '#ffffff',
              :enabled => false,
            },
        }
      chart.options[:title][:text] = 'Past month'
      chart.series(mood_totals_pie)
    end
  end

  def hide_lines
    0 # Width 0 hides lines.
  end

# Convert ActiveRecord timestamp to Javascript Date.UTC format
  def javascript_date_utc(timestamp)
# http://kevin.h-pk-ns.com/2011/09/01/ruby-datetime-to-javascript-date-conversion/
# http://www.w3schools.com/jsref/jsref_utc.asp
    timestamp.tv_sec * milliseconds_per_second
  end

  def milliseconds_per_second
    1000
  end

  def mood_field_names
    [:happiness_level, :anxiety_level, :irritation_level]
  end

  def mood_information_basic_line(field_name)
# http://api.highcharts.com/highcharts#series.data
    {
      :name => field_name.to_s.capitalize.gsub('_',' '),
      :data => mood_values(field_name),
    }
  end

  def mood_total(field_name)
    recent = mood_values(field_name).select do |javascript_date_utc, _|
      javascript_date_utc > @a_month_ago
    end
    recent.map{|_, mood_level| mood_level}.reduce(:+)
  end

  def mood_totals_pie
    labels = mood_field_names.map{|mood| "#{mood.to_s.split('_').first.capitalize} total"}
    totals = mood_field_names.map{|mood| mood_total(mood)}
    includable = labels.zip(totals).reject{|label,total| 0==total}
    {
      :data => includable,
      :name => ' ', # Empty string doesn't work.
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

  def seconds_in_a_day
    60*60*24
  end
end
