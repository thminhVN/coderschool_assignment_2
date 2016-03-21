class CreateFriendShips < ActiveRecord::Migration
  def change
    create_table :friend_ships do |t|
      t.references :request_from, index: true, foreign_key: true, references: :users
      t.references :request_to, index: true, foreign_key: true, references: :users
      t.integer :status

      t.timestamps null: false
    end
  end
end
