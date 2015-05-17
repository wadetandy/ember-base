class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer   :user_id
      t.string    :provider
      t.string    :provider_uuid
      t.string    :token
      t.timestamp :token_expires_at

      t.timestamps null: false
    end
  end
end
