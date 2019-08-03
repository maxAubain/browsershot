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
      create_screenshots

      redirect_to root_path
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
    img_path = "image.png"
    counter = 0

    urls_split.each do |url|
      @screenshot = Screenshot.create(url: url, img_path: "./app/assets/images/" + @screenshotreq.id.to_s + "." + counter.to_s + ".png")
      @screenshot.screenshotreq = @screenshotreq
      @screenshot.save!
      counter += 1
    end
  end

  def create_screenshots
    ws = Webshot::Screenshot.instance

    @screenshotreq.screenshots.each do |screenshot|
      ws.capture screenshot.url, screenshot.img_path
      binding.pry
    end
    
    flash[:notice] = 'The screenshots have been generated and saved.'
  end
end
