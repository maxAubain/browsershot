class ScreenshotreqsController < ApplicationController
  def new
    @screenshotreq = Screenshotreq.new
  end

  def create
    @screenshotreq = Screenshotreq.new(screenshotreq_params)
    
    if @screenshotreq.save
      redirect_to root_path
      parse_urls(@screenshotreq)
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
end
