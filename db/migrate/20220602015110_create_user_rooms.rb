class CreateUserRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_rooms do |t|
      t.integer :user_id
      t.string :room_id
      t.string :integer

      t.timestamps
    end
  end
end
