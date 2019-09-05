class Screenshotreq < ApplicationRecord
  
  # Validations for each screenshot request: request name and list of at least one URL
  validates :name, presence: true
  validates :urls, presence: true

  # Each screenshot request will have at least one screenshot
  has_many :screenshots
  
end
