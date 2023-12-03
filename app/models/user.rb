class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :habits, dependent: :destroy
  has_many :trackers, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  after_create :attach_default_avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  def avatar_url
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end

  def attach_default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar.jpg')), filename: 'default-avatar.jpg', content_type: 'image/jpg')
    end
  end
end
