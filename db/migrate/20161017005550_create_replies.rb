class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :reply_text
      t.integer :text_id
      t.string :username

      t.timestamps null: false
    end
  end
end
