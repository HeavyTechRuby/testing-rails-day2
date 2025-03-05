class Podcast < ApplicationRecord
  validates :title, presence: true, format: { with: /[a-z]+/i }
  validate :author_not_blocked

  belongs_to :author, class_name: "User"
  has_many :subscriptions
  has_many :episodes

  before_create -> { author.build_account }, if: -> { author.account.nil? }
  
  scope :published, -> { where(status: [:published]) }

  def author_not_blocked
    return if author.nil?

    if author.blocked?
      errors.add(:author, "is blocked")
    end
  end

  def subscribe(user)
    subscriptions.build(user: user)
  end

  def unsubscribe(user)
    subscriptions.each do |subscription|
      return unless subscription.user == user

    subscriptions.delete(subscription)
    end
  end

  def publish(episode)
    self.episodes << episode
    episode.publish
  end

  def add_draft(episode)
    self.episodes << episode
    episode.draft
  end

  def archived?
    status == "archived"
  end
end
