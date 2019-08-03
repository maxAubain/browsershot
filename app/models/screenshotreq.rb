class Screenshotreq < ApplicationRecord
  validates :name, presence: true
  validates :urls, presence: true
  has_many :screenshots
end
