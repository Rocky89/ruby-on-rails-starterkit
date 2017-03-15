class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notification_id
      t.string  :notification_message
      t.string  :action
      t.integer :notified_id

      t.timestamps
    end

    add_foreign_key "notifications", "users", on_delete: :cascade
    
  end
end
