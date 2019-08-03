FactoryBot.define do
  factory :screenshot do
    url { "https://www.google.com/" }
    img_path { "./app/assets/images/img.png" }
  end
end
