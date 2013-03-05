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

  def happiness_level_width
    happiness_level * 20
  end

  def anxiety_level_width
    anxiety_level * 20
  end

  def irritation_level_width
    irritation_level * 20
  end

end
