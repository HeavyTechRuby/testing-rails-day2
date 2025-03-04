class Episode < ApplicationRecord
  validates :title, presence: true, format: { with: /[a-z]+/i }
  validate :podcast_not_archived

  belongs_to :podcast
  has_many :likes

  scope :published, -> { where(status: :published) }
  scope :popular, -> { joins(:likes) }

  def publish
    self.status = "published"
  end

  def published?
    self.status == "published"
  end

  def draft
    self.status = "draft"
  end

  def draft?
    self.status == "draft"
  end

  def podcast_not_archived
    return if podcast.nil?

    if podcast.archived?
      errors.add(:podcast, "is archived")
    end
  end
end
