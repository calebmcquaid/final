class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :competition_users
  has_many :competitions, through: :competition_users
  has_many :stats

  has_one_attached :avatar

  def stats_for_competition(competition)
    stats.where(competition: competition)
  end
end
