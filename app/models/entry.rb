class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Likeable

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

  # Syntactic sugar for class method
  # def self.recent(3)
  #   desc(:created_at).limit(3)
  # end
  scope :latest, desc(:created_at).limit(3)

  def self.mood_chart
    LazyHighCharts::HighChart.new('pie') do |chart|
      chart.options[:chart][:defaultSeriesType] = "pie"
      chart.options[:chart][:height] = 210
      chart.options[:title][:text] = "Issues on everybody's mind"
      chart.options[:chart][:backgroundColor] = '#f5f0d7'
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
