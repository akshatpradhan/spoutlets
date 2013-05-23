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
      chart.options[:title][:text] = 'Mood chart of your journal'
      chart.series({
                     name: 'Totals',
                     data: [
                            ['Happiness', fetch_happiness_level],
                            ['Anxiety', fetch_anxiety_level],
                            ['Irritation', fetch_irritation_level]
                           ]

                    })
    end
  end

  def fetch_happiness_level
    self.entries.map do |entry|
      entry.happiness_level
    end.compact.inject(:+)
  end

  def fetch_anxiety_level
    self.entries.map do |entry|
      entry.anxiety_level
    end.compact.inject(:+)
  end

  def fetch_irritation_level
    self.entries.map do |entry|
      entry.irritation_level
    end.compact.inject(:+)
  end

  # Interesting way to fetch persons mood levels and put in an array
  # def fetch_irritation_level
  #   self.entries.map do |entry|
  #     [entry.created_at, entry.irritation_level]
  #   end
  # end
end
