class ScreenshotreqsController < ApplicationController
  def index
    @screenshotreqs = Screenshotreq.all
  end
  
  def new
    @screenshotreq = Screenshotreq.new
  end

  def create
    @screenshotreq = Screenshotreq.new(screenshotreq_params)
    
    if @screenshotreq.save
      # parse URLs
      parse_urls
      
      # capture and save screenshots
      create_screenshots

      redirect_to root_path
    end
  end

  def show
    @screenshotreq = Screenshotreq.find(params[:id])
  end

  private

  def screenshotreq_params
    params.require(:screenshotreq).permit(:name, :urls)
  end

  def parse_urls
    urls = []
    urls.push(@screenshotreq.urls.gsub(/\s+/, ""))
    urls_split = urls[0].split(";")
    counter = 1
    urls_split.each do |url|
      @screenshot = Screenshot.create(url: url, img_path: "./app/assets/images/req" + @screenshotreq.id.to_s + "shot" + counter.to_s + ".png")
      @screenshot.screenshotreq = @screenshotreq
      @screenshot.save!
      counter += 1
    end
  end

  def create_screenshots
    ws = Webshot::Screenshot.instance
    @screenshotreq.screenshots.each do |screenshot|
      ws.capture screenshot.url, screenshot.img_path, width: 1024, height: 768
    end
    flash[:notice] = 'The screenshots have been generated and saved.'
  end
end
