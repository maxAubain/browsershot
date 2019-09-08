require 'rails_helper'

RSpec.describe "Backend", type: :request do

  describe 'can work backend to frontend by' do
    # Testing back to front screenshotreq data flow pattern.
    
    let(:test_request_name){ "test_req" }
    let(:saved_request){ Screenshotreq.create(name: test_request_name, urls: "https://www.google.com") }
    # Save screenshotreq in database.
    
    it 'processing GET request for screenshotreq' do
      get screenshotreq_path(saved_request[:id])
      expect(response).to be_successful
      expect(response.body).to include(test_request_name)
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