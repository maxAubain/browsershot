require 'rails_helper'

RSpec.describe "Show view", type: :request do
  describe 'can retrieve screenshotreq by GET request' do
    # Testing back to front screenshotreq data flow pattern.
    
    let(:screenshotreq_name){ "test_req" }
    let(:screenshotreq_urls){ "https://www.google.com" }
    let(:screenshotreq){instance_double(screenshotreq_name, name: screenshotreq_name, urls: screenshotreq_urls)}
    # Create non-saved instance of screenshotreq, stubbing out the new.html.erb form.
    
    before do
      params = {
        name: screenshotreq_name,
        urls: screenshotreq_urls
      }
      post('/screenshotreqs', params: {screenshotreq: params})
    end
    # Save a screenshotreq with POST to 'screenshotreqs#create' controller action.

    before(:each) do
      screenshotreq_id = Screenshotreq.find_by(name: screenshotreq_name).id
      path = "/screenshotreqs/#{screenshotreq_id}"
      params = {
        id: screenshotreq_id
      }
      get(path, params: {screenshotreq: params})
    end
    # GET saved screenshotreq before each test.
    
    describe '' do
      it '200 response and screenshotreq name is verified' do
        expect(response).to be_successful
        expect(response.body).to include(screenshotreq_name)
      end
      # Check success and body of GET request for saved screenshotreq.

      it 'screenshot url is verified' do
        screenshot = Screenshot.find_by(url: screenshotreq_urls)
        expect(response.body).to include(screenshot.url)
      end
      # Check body of GET request for saved screenshot url.

      it 'screenshot image is verified' do
        screenshot = Screenshot.find_by(url: screenshotreq_urls)
        expect(response.body).to include(screenshot.image_file_name)
      end
      # Check body of GET request for saved screenshot image reference.

    end
  end
end

#it 'processing GET request for Index screenshotreq' do
#  recent_save_id = Screenshotreq.find_by(name: screenshotreq_name).id
  # params = {
  #   id: recent_save_id
  # }
  # get('/screenshotreqs/', params: {screenshotreq: params})
#  binding.pry
  # expect(response).to be_successful
  # expect(response.body).to include(screenshotreq_name)
#end
# Check success and body of GET request for saved screenshotreq.