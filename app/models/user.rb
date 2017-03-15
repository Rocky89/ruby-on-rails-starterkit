class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :auth_token

  has_many :device_tokens
  has_many :notifications
  has_many :notified_notifications, foreign_key: 'notified_id', class_name: 'Notification'
end
