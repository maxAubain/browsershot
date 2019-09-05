class Screenshot < ApplicationRecord
  
  # Validations for each screenshot: URL, image path target
  validates :url, presence: true
  validates :img_path, presence: true
  validates :img_path_short, presence: true
  
  # Screenshots must belong to its assocaited screenshot request
  belongs_to :screenshotreq
  
end
