class ChartFactory

  def initialize(user)
    @user = user
  end

  def build_chart(chart_type)
# https://github.com/michelson/lazy_high_charts/blob/master/lib/lazy_high_charts/high_chart.rb
# http://api.highcharts.com/highcharts

    entries = @user.entries
    ::LazyHighCharts::HighChart.new(random_canvas_id) do |chart|
      chart.options[:chart][:defaultSeriesType] = chart_type
      chart.series(MoodChartSeriesFactory.new( :happiness_level).series(entries))
      chart.series(MoodChartSeriesFactory.new(   :anxiety_level).series(entries))
      chart.series(MoodChartSeriesFactory.new(:irritation_level).series(entries))
    end
  end

  private 

  def random_canvas_id
# Don't use SecureRandom.urlsafe_base64; it gives invalid characters.
    ('a'..'z').to_a.shuffle[0,3].join
  end
end
