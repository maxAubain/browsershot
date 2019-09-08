require 'rails_helper'

RSpec.describe "Frontend", type: :request do
  # Request specs that primarily test the screenshotreq controller.

  describe 'can work frontend to backend by' do
    # Testing front to back screenshotreq data flow pattern.

    let(:screenshotreq_name){ "test_req" }
    let(:screenshotreq_urls){ "https://www.google.com" }
    let(:screenshotreq){instance_double(screenshotreq_name, name: screenshotreq_name, urls: screenshotreq_urls)}
    # Create non-saved instance of screenshotreq, stubbing out the new.html.erb form.
    
    before 'processing screenshotreq POST request' do
      params = {
        name: screenshotreq_name,
        urls: screenshotreq_urls
      }
      post('/screenshotreqs', params: {screenshotreq: params})
    end
    # Save a screenshotreq with POST to 'screenshotreqs#create' controller action.

    it 'saving screenshotreq, has one url' do
      screenshotreq_saved = Screenshotreq.find_by(name: screenshotreq_name)
      expect(screenshotreq_saved.name).to eq(screenshotreq.name)
    end
    # Compare saved screenshotreq name to stubbed form screenshotreq name.

    it 'and saving associated screenshot' do
      screenshotreq_saved = Screenshotreq.find_by(name: screenshotreq_name)
      screenshot_saved = Screenshot.find_by(url: screenshotreq_urls)
      expect(screenshot_saved.screenshotreq_id).to eq(screenshotreq_saved.id)
    end
    # Confirm that screenshot is saved with screenshotreq and
    # association between screenshotreq and screenshot is made.

    it 'and saving the screenshot image association' do
      screenshot_saved = Screenshot.find_by(url: screenshotreq_urls)
      expect(screenshot_saved.id).to eq(screenshot_saved.image.record.id)
    end
    # Confirm assocation between screenshot to image using image record id.

    it 'and saving the screenshot image' do
      screenshot_saved = Screenshot.find_by(url: screenshotreq_urls)
      file_exist = File.exist?(screenshot_saved.img_path)
      file_type = File.ftype(screenshot_saved.img_path)
      binding.pry
      expect(file_exist).to eq(true)
      expect(file_type).to eq("file")
    end
    # Confirm presence and type of generated screenshot image file.

  end
end