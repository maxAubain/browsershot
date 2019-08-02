class ScreenshotreqsController < ApplicationController
  def new
    @screenshotreq = Screenshotreq.new
  end

  def create
    @screenshotreq = Screenshotreq.new(screenshotreq_params)
    
    if @screenshotreq.save
      # parse URLs
      parse_urls(@screenshotreq)
      
      # capture and save screenshots
      get_screenshots(@screenshotreq)

      redirect_to root_path
      flash[:notice] = 'Your request has been submitted.'
    end
  end

  private

  def screenshotreq_params
    params.require(:screenshotreq).permit(:name, :urls)
  end

  def parse_urls(screenshotreq)
    @screenshotreq.urls = screenshotreq.urls.gsub(/\s+/, "").split(";")
    @screenshotreq.save
  end

  def get_screenshots(screenshotreq)
    ws = Webshot::Screenshot.instance
    ws.capture "http://www.google.com/", "google.png"
    binding.pry
  end
end
