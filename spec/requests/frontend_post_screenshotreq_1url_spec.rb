require 'rails_helper'

RSpec.describe "Frontend", type: :request do
  # Request specs that primarily test the screenshotreq controller.

  describe 'can work frontend to backend by' do
    # Testing front to back screenshotreq data flow pattern.

    let(:test_request_name){ "test_req" }
    let(:test_URLs){ "https://www.google.com" }
    let(:screenshotreq){instance_double(test_request_name, name: test_request_name, urls: test_URLs)}
    # Create non-saved instance of screenshotreq, stubbing out the new.html.erb form.
    
    before 'processing screenshotreq POST request' do
      params = {
        name: test_request_name,
        urls: test_URLs
      }
      post('/screenshotreqs', params: {screenshotreq: params})
    end
    # Save a screenshotreq with POST to 'screenshotreqs#create' controller action.

    it 'saving screenshotreq, has one url' do
      screenshotreq_saved = Screenshotreq.find_by(name: test_request_name)
      expect(screenshotreq_saved.name).to eq(screenshotreq.name)
    end
    # Compare saved screenshotreq name to stubbed form screenshotreq name.

    it 'and saving associated screenshot' do
      screenshotreq_saved = Screenshotreq.find_by(name: test_request_name)
      screenshot_saved = Screenshot.find_by(url: test_URLs)
      expect(screenshot_saved.screenshotreq_id).to eq(screenshotreq_saved.id)
    end
    # Confirm that screenshot is automatically saved with screenshotreq
    # and association between screenshotreq and screenshot.

    it 'and saving the screenshot image' do
    end
    # Confirm presence of auto-generated screenshot image.

    it 'and saving the screenshot image association' do
    end
    # Confirm assocation between screenshot to image.

  end
end