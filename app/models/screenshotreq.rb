class Screenshotreq < ApplicationRecord
  validates :name, presence: true
  validates :urls, presence: true
end
