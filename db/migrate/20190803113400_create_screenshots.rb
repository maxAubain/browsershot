class CreateScreenshots < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshots do |t|
      t.belongs_to :screenshotreq, index: true
      t.string :url
      t.string :img_path

      t.timestamps
    end
  end
end