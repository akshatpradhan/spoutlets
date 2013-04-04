module UsersHelper

  def issues_chart(chart_type)
# https://github.com/michelson/lazy_high_charts/blob/master/lib/lazy_high_charts/high_chart.rb
# https://github.com/michelson/lazy_high_charts/blob/master/lib/lazy_high_charts/layout_helper.rb
    chart = Chart.new.build_chart(@user, chart_type)
    high_chart(chart.canvas, chart)
  end
end
