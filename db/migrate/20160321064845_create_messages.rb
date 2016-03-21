class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender, index: true, foreign_key: true, references: :users
      t.references :receiver, index: true, foreign_key: true, references: :users
      t.text :message
      t.integer :status

      t.timestamps null: false
    end
  end
end
