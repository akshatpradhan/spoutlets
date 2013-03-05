class Entry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,            type: String
  field :content,          type: String
  field :happiness_level,  type: String
  field :anxiety_level,    type: String
  field :irritation_level, type: String
  field :category,         type: String
  field :published,        type: Boolean

  belongs_to :user

  validates :content, presence: true

  def happiness_level_width
    happiness_level.to_i * 20
  end

  def anxiety_level_width
    anxiety_level.to_i * 20
  end

  def irritation_level_width
    irritation_level.to_i * 20
  end

end
