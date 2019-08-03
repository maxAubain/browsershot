FactoryBot.define do
  factory :screenshot do
    url { "https://www.google.com/" }
    img_path { "./app/assets/images/img.png" }
    img_path_short { "img.png"}
    screenshotreq
  end
end
