class Screenshot < ApplicationRecord
  validates :url, presence: true
  validates :image_file_path, presence: true
  validates :image_file_name, presence: true
  # Validate screenshot parameters: URL, image path, image name

  belongs_to :screenshotreq
  # Associate Screenshots to one Screenshotreq

  has_one_attached :image
  # Associate screenshot image stored in Active Storage with Screenshot
end
