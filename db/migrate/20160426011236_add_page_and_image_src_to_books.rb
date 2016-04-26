class AddPageAndImageSrcToBooks < ActiveRecord::Migration
  def change
    add_column :books, :page, :integer
    add_column :books, :image_src, :string
  end
end
