class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "inactive"
      t.datetime :key_timestamp
    end
    add_index :users, [:state]

    create_table :authorizations do |t|
      t.string   :provider, :null => false
      t.string   :uid, :null => false
      t.string   :email_address
      t.string   :name
      t.string   :nickname
      t.string   :location
      t.string   :image
      t.text     :description
      t.string   :phone
      t.text     :urls
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :authorizations, [:provider]
    add_index :authorizations, [:uid]
    add_index :authorizations, [:email_address]
    add_index :authorizations, [:user_id]
  end

  def self.down
    drop_table :users
    drop_table :authorizations
  end
end
