class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      #t.references :user, foreign_key: true
      #t.references :group, foreign_key: true

      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
