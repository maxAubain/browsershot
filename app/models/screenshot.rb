class Screenshot < ApplicationRecord
  validates :url, presence: true
  validates :img_path, presence: true
  belongs_to :screenshotreq
end
