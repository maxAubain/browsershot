class CreateScreenshots < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshots do |t|
      t.belongs_to :screenshotreq, index: true
      t.string :url
      t.string :image_file_path
      t.string :image_file_name

      t.timestamps
    end
  end
end
