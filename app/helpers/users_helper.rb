module UsersHelper

  def issues_spline_chart
    high_chart('chart_id', Chart.new(@user).build_chart)
  end
end
