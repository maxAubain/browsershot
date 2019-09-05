class CreateScreenshotreqs < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshotreqs do |t|
      t.string :name
      t.text :urls

      t.timestamps
    end
  end
end
