class User < ApplicationRecord
  has_one :account, autosave: true
  has_many :likes

  def block
    self.blocked = true
  end

  def like(episode)
    likes.build(episode:)
  end

  def unlike(episode)
    likes.find_by(episode:).destroy
  end
end
