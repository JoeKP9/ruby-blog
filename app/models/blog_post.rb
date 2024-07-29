class BlogPost < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true

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