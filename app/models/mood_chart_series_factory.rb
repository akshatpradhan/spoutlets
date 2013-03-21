class MoodChartSeriesFactory

  def initialize(field_name)
    @field_name = field_name
  end

  def series(mood_entries)
    {
        :name => @field_name.to_s,
        :data => series_of_tuples(mood_entries),
    }
  end 

  private

  def series_of_tuples(entries)
    entries.map{|entry| tuple_for_chart(entry)}
  end

  def tuple_for_chart(entry)
    [
      entry.created_at,
      entry.send(@field_name),   # entry.happiness
    ]
  end
end

