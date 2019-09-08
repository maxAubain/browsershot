FactoryBot.define do
  factory :screenshot do
    url { "https://www.google.com/" }
    image_file_path { "./storage/img.png" }
    image_file_name { "img.png"}
    screenshotreq # Generates associates screenshotreq.
  end
end
