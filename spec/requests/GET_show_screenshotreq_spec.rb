require 'rails_helper'

RSpec.describe "Show view", type: :request do
  describe 'can retrieve screenshotreq by GET request' do
    # Testing back to front screenshotreq data flow pattern.
    
    let(:screenshotreq_name){ "test_req" }
    let(:screenshotreq_urls){ "https://www.google.com" }
    let(:screenshotreq){instance_double(screenshotreq_name, name: screenshotreq_name, urls: screenshotreq_urls)}
    # Create non-saved instance of screenshotreq, stubbing out the new.html.erb form.
    
    before do
      params_post = {
        name: screenshotreq_name,
        urls: screenshotreq_urls
      }
      post('/screenshotreqs', params: {screenshotreq: params_post})
      # Save a screenshotreq with POST to 'screenshotreqs#create' controller action.

      screenshotreq_id = Screenshotreq.find_by(name: screenshotreq_name).id
      path = "/screenshotreqs/#{screenshotreq_id}" # URI pattern for screenshotreqs#show
      params_get = {
        id: screenshotreq_id
      }
      get(path, params: {screenshotreq: params_get})
      # GET saved screenshotreq.
    end
    
    describe do
      it '200 response and screenshotreq name is verified' do
        expect(response).to be_successful
        expect(response.body).to include(screenshotreq_name)
      end
      # Check GET request response status and body.

      it 'screenshot url is verified' do
        screenshot = Screenshot.find_by(url: screenshotreq_urls)
        expect(response.body).to include(screenshot.url)
      end
      # Check GET request response body for saved screenshot url.

      it 'screenshot image is verified' do
        screenshot = Screenshot.find_by(url: screenshotreq_urls)
        expect(response.body).to include(screenshot.image_file_name)
      end
      # Check GET request response body for saved screenshot image reference.

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