class User
  include Mongoid::Document
  include Mongoid::Timestamps
  rolify
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  has_many :entries
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :uid, :name, :email

  validates :name, presence: true
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

  def mood_chart
    LazyHighCharts::HighChart.new('pie') do |chart|
      chart.options[:chart][:defaultSeriesType] = "pie"
      chart.options[:chart][:height] = 210
      chart.options[:title][:text] = 'Stuff affecting you the most'
      chart.series({
                     name: 'Total',
                     data: fetch_categories
                   })
    end
  end

  def fetch_categories
    categories = self.entries.map do |entry|
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
