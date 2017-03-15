class AddHasNotificationsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :has_notifications, :bool, default: true
  end
end
