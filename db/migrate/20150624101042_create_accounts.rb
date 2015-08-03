class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.timestamps null: false
      t.string :subdomain
      t.string :password
      t.string :email
      t.boolean :user_logged_in
    end
  end
end
