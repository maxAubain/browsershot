FactoryBot.define do
  factory :screenshot do
    url { "https://www.google.com/" }
    img_path { "./storage/img.png" }
    img_path_short { "img.png"}
    screenshotreq # Generates associates screenshotreq.
  end
end
