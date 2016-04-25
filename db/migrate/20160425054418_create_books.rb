class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :amazon_id
      t.string :title
      t.string :author
      t.string :publisher
      t.date :published_at

      t.timestamps null: false
    end
  end
end
