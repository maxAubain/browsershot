require 'rails_helper'

RSpec.describe "Backend", type: :request do

  describe 'can work backend to frontend by' do
    # Testing back to front screenshotreq data flow pattern.
    
    let(:screenshotreq_name){ "test_req" }
    let(:saved_screenshotreq){ Screenshotreq.create(name: screenshotreq_name, urls: "https://www.google.com") }
    # Save screenshotreq in database.
    
    it 'processing GET request for screenshotreq' do
      get screenshotreq_path(saved_screenshotreq[:id])
      expect(response).to be_successful
      expect(response.body).to include(screenshotreq_name)
    end
    # Check success and body of GET request for saved screenshotreq.

    it 'processing GET request for screenshot url' do
    end
    # Check success and body of GET request for saved screenshot.

    it 'processing GET request for screenshot image' do
    end
    # Check success of GET request for saved screenshot image.

  end
end