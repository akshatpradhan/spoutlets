class Entry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,            type: String
  field :content,          type: String
  field :happiness_level,  type: Integer
  field :anxiety_level,    type: Integer
  field :irritation_level, type: Integer
  field :category,         type: String
  field :published,        type: Boolean

  belongs_to :user

  validates :content, presence: true
  validates :category, presence: true

  def self.mood_chart
    LazyHighCharts::HighChart.new('pie') do |chart|
      chart.options[:chart][:defaultSeriesType] = "pie"
      chart.options[:chart][:height] = 210
      chart.options[:title][:text] = 'Stuff affecting the community the most'
      chart.series({
                     name: 'Total',
                     data: fetch_categories
                   })
    end
  end

  def self.fetch_categories
    categories = all.map do |entry|
      entry.category
    end

    {}.tap do |h|
      categories.each do |category|
        h[category] ||= 0
        h[category] += 1
      end
    end.to_a
  end

end
