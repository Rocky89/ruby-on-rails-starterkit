class Notification < ApplicationRecord
  # notified_id the user who receives the notification
  # user_id the user who creates the notification / current user
  validates :user_id, :notification_id, :notification_message, :action,
            presence: true

  belongs_to :notified_user, foreign_key: 'notified_id', class_name: 'User'
  belongs_to :user
end
