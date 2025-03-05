class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
