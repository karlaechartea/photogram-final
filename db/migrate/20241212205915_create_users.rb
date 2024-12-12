class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :comments_count
      t.string :email
      t.string :encrypted_password
      t.integer :likes_count
      t.boolean :private
      t.datetime :remember_created_at
      t.datetime :reset_password_sent_at
      t.string :reset_password_token
      t.string :username

      t.timestamps # Automatically adds created_at and updated_at
    end
  end
end
