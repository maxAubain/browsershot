class ScreenshotreqsController < ApplicationController
  def new
    @screenshotreq = Screenshotreq.new
  end

  def create
    @screenshotreq = Screenshotreq.new(screenshotreq_params)
    
    if @screenshotreq.save
      # parse URLs
      parse_urls
      
      # capture and save screenshots
      # get_screenshots

      redirect_to root_path
      flash[:notice] = 'Your request has been submitted.'
    end
  end

  private

  def screenshotreq_params
    params.require(:screenshotreq).permit(:name, :urls)
  end

  def parse_urls
    urls = []
    urls.push(@screenshotreq.urls.gsub(/\s+/, ""))
    urls_split = urls[0].split(";")
    img_path = ""

    @screenshot = Screenshot.new(url: urls_split[0], img_path: img_path)

    binding.pry
  end

  # def get_screenshots(screenshotreq)
  #   ws = Webshot::Screenshot.instance
  #   ws.capture "http://www.google.com/", "google.png"
  # end
end
