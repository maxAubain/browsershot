class Screenshot < ApplicationRecord
  validates :url, presence: true
  validates :img_path, presence: true
end
