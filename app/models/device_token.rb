class DeviceToken < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :device_token
  validates_presence_of :device_token, :operating_system, :user_id
  validates_inclusion_of :operating_system, in: [0, 1]
end
