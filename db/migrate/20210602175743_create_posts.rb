class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.datetime :published

      t.timestamps
    end
  end
end
