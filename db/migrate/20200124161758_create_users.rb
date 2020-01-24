class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.column :email, :string
      t.column :password_hash, :string
      t.column :password_salt, :string
      t.column :user_name, :string
      t.column :admin, :boolean         
      t.timestamps
    end
  end
end
