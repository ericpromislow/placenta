class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :is_temporary
      t.integer :profile_id

      t.timestamps
    end
    add_index :users, [:username, :email]
  end
end
