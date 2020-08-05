class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_many :galleries

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :galleried, -> { joins(:galleries)}
end
