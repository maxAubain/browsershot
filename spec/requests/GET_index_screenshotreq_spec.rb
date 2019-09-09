require 'rails_helper'

RSpec.describe "Index view", type: :request do
  describe 'can retrieve screenshotreqs by GET request' do
    # Testing back to front screenshotreq data flow pattern.
    
    let(:screenshotreq_name_1){ "test_req_1" }
    let(:screenshotreq_urls_1){ "https://www.google.com" }
    let(:screenshotreq_1){instance_double(screenshotreq_name_1, name: screenshotreq_name_1, urls: screenshotreq_urls_1)}
    let(:screenshotreq_name_2){ "test_req_2" }
    let(:screenshotreq_urls_2){ "https://www.google.com/maps" }
    let(:screenshotreq_2){instance_double(screenshotreq_name_2, name: screenshotreq_name_2, urls: screenshotreq_urls_2)}
    # Create non-saved two instances of screenshotreq, stubbing out the new.html.erb form.
    
    before do
      params_post_1 = {
        name: screenshotreq_name_1,
        urls: screenshotreq_urls_1
      }
      post('/screenshotreqs', params: {screenshotreq: params_post_1})

      params_post_2 = {
        name: screenshotreq_name_2,
        urls: screenshotreq_urls_2
      }
      post('/screenshotreqs', params: {screenshotreq: params_post_2})
      # Save screenshotreqs with POST to 'screenshotreqs#create' controller action.

      path = "/screenshotreqs" # URI pattern for screenshotreqs#index
      get(path)
      # GET saved screenshotreqs using index path.
    end
    
    describe do
      it 'Two screenshotreqs are saved' do
        expect(Screenshotreq.all.length).to eq(2)
      end

      it '200 response to GET request is verified' do
        expect(response).to be_successful
      end
      # Check GET request response status.

      it 'first screenshotreq is verified in response body' do
        expect(response.body).to include(screenshotreq_name_1)
      end
      # Check GET request response body for name of first screenshotreq.

      it 'second screenshotreq is verified in response body' do
        expect(response.body).to include(screenshotreq_name_2)
      end
      # Check GET request response body for name of second screenshotreq.

      it 'Show link is verified in response body' do
        expect(response.body).to include("Show")
      end
      # Check GET request response body for label of show link.

      it 'Delete link is verified in response body' do
        expect(response.body).to include("Delete")
      end
      # Check GET request response body for label of delete link.

    end
  end
end