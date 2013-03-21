class Chart

  def initialize(user)
    @entries = user.entries
  end

  def build_chart
    ::LazyHighCharts::HighChart.new('chart_id') do |h|
      h.options[:chart][:defaultSeriesType] = 'spline'
      h.series(:name => 'happiness_level', :data => happiness)
      h.series(:name =>   'anxiety_level', :data => anxiety)
      h.series(:name =>'irritation_level', :data => irritation)
    end
  end

  private

  def anxiety
    @entries.map{|e| [ e.created_at, e.anxiety_level ]}
  end

  def happiness
    @entries.map{|e| [ e.created_at, e.happiness_level ]}
  end

  def irritation
    @entries.map{|e| [ e.created_at, e.irritation_level ]}
  end
end
