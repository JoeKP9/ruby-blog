class BlogPost < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted, -> {order(arel_table[:published_at].desc.nulls_first).order(updated_at: :asc)}
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

end

# BlogPosts.all
# BlogPosts.draft
# BlogPosts.published
# BlogPosts.scheduled