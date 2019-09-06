class Screenshotreq < ApplicationRecord
  
  # Validations for each screenshot request: request name and list of at least one URL
  validates :name, presence: true
  validates :urls, presence: true

  # Each screenshot request will have at least one screenshot
  # When a screenshot request is deleted, it will deleted the associated screenshots
  has_many :screenshots, dependent: :destroy
  
end
