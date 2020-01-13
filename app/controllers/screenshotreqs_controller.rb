# frozen_string_literal: true

class ScreenshotreqsController < ApplicationController
  # This controller governs CRUD functions for Screenshotreq(uest)s and Screenshots

  def index
    # Calls all instances of Screenshotreq model to index page.
    @screenshotreqs = Screenshotreq.all
  end

  def new
    # Required for `create` method.
    @screenshotreq = Screenshotreq.new
  end

  def create
    # CREATE screenshot req instance with validated input parameters.
    @screenshotreq = Screenshotreq.new(screenshotreq_params)

    if @screenshotreq.save
      # If parameters are validated, the URL parameter is parsed...
      parse_urls

      # ... and one screenshot instance is saved per URL.
      create_screenshot_images

      redirect_to root_path
    end
  end

  def show
    # GET saved screenshotreqs.
    @screenshotreq = Screenshotreq.find(params[:id])
  end

  def destroy
    # DELETE saved screenshotreq.
    @screenshotreq = Screenshotreq.find(params[:id])
    @screenshotreq.destroy

    redirect_to root_path

    flash[:notice] = 'Browsershot result has been deleted.'
  end

  private
  # Private methods are not accessible from calls beyond this controller.

  def screenshotreq_params
    # Instantiate screenshotreq parameters.
    params.require(:screenshotreq)
          .permit(:name, :urls)
  end

  def parse_urls
    urls = []
    urls.push(@screenshotreq.urls.gsub(/\s+/, ''))
    # Assign URLs string into an array and remove any whitespace from string.

    urls_split = urls[0].split(';')
    # Mutate single-var URLs string array into an array of multiple URL string vars.

    counter = 1
    urls_split.each do |url|
      image_file_path = "./storage"
      image_file_name = "req#{@screenshotreq.id}shot#{counter}.png"
      @screenshot = Screenshot.create(url: url,
                                      image_file_path: image_file_path,
                                      image_file_name: image_file_name)
      # CREATE one screenshot instance per URL

      @screenshot.screenshotreq = @screenshotreq
      # Associate screenshot instances with screenshotreq instance

      @screenshot.save!
      counter += 1
    end
  end

  def create_screenshot_images
  # Use helper methods provided by ruby_webshot gem to obtain image files.

    @screenshotreq.screenshots.each do |screenshot|
      RubyWebshot.call(screenshot.url,
                       save_file_path: screenshot.image_file_path, 
                       file_name: screenshot.image_file_name, 
                       width: 1024, 
                       height: 768)

      screenshot.image.attach(io: File.open("#{screenshot.image_file_path}/#{screenshot.image_file_name}"),
                              filename: screenshot.image_file_name)
      # Associate captured image file with screenshot instance.
    end

    flash[:notice] = 'Browsershot request has been executed and saved.'
  end
end
