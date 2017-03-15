class CreateDeviceTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :device_tokens do |t|
      t.integer :user_id
      t.string :device_token
      t.integer :operating_system
      t.string :aws_endpoint

      t.timestamps
    end
    add_foreign_key "device_tokens", "users", on_delete: :cascade
  end
end
