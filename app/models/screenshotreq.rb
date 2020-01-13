class Screenshotreq < ApplicationRecord
  validates :name, presence: true
  validates :urls, presence: true
  # Validate screenshotreq parameters: name, urls.

  has_many :screenshots, dependent: :destroy
  # Associate and screenshots with screenshotreq / DELETE associated screenshots with screensshotreq DELETE.
end
