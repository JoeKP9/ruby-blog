class BlogPost < ApplicationRecord

  has_rich_text :content

  validates :title, presence: true, length: {maximum: 35}
  validates :content, presence: true

  scope :sorted, -> {order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc)}
  scope :search, ->(text) {sorted.where("title like ?", "%"+text.to_s+"%")
  .or(sorted.where("UID like ?", "%"+text.to_s+"%"))
  .or(sorted.where("UID like ?", User.where("username like ?", "%"+text.to_s+"%").ids[0]))}
  # scope :sorted, -> {order(published_at: :desc, updated_at: :asc)}
  scope :draft, -> {where(published_at: nil)}
  scope :published, -> {where("published_at <= ?", Time.current)}
  scope :scheduled, -> {where("published_at > ?", Time.current)}

  def draft?
    published_at.nil?
  end
  
  def scheduled?
    published_at? && published_at > Time.current
  end

  def private?
    public? == false
  end

  def edited?
    published_at? && created_at < updated_at - 1.minute
  end
end

# BlogPosts.all
# BlogPosts.draft
# BlogPosts.published
# BlogPosts.scheduled