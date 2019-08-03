class Screenshot < ApplicationRecord
  validates :url, presence: true
  validates :img_path, presence: true
  validates :img_path_short, presence: true
  belongs_to :screenshotreq
end
