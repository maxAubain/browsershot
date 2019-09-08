# frozen_string_literal: true

class ScreenshotreqsController < ApplicationController
  # This controller governs CRUD functions for Screenshotreqs
  # (short for "screenshot requests") and Screenshots.

  def index
    @screenshotreqs = Screenshotreq.all
    # index method sends all screenshot request params to the front page: 
    # index.html.erb
  end

  def new
    @screenshotreq = Screenshotreq.new
    # Enables create method.
  end

  def create
    @screenshotreq = Screenshotreq.new(screenshotreq_params)
    # Creates a new instance of a screenshotreq with data submitted from 
    # the form in new.html.erb. When the "submit request" button on the 
    # form is clicked, the input URLs and request name is checked against 
    # the model validation criteria.

    if @screenshotreq.save
      # If validation criteria is met, save is successful and...
      parse_urls
      # URLs from the list of URLs submitted in the form are parsed.

      create_screenshots
      # create and save screenshots

      redirect_to root_path
      # Redirect view to home page after save.
    end
  end

  def show
    @screenshotreq = Screenshotreq.find(params[:id])
    # Show method finds saved screenshotreq data and sends to a new 
    # view configured in show.html.erb.
  end

  def destroy
    @screenshotreq = Screenshotreq.find(params[:id])
    @screenshotreq.destroy
    # Delete saved screenshotreq.
   
    redirect_to root_path
    # Redirect view to home page after delete.

    flash[:notice] = 'Screenshot request has been deleted.'
  end

  private
  # private methods arenot accessible from calls beyond this 
  # controller.

  def screenshotreq_params
    params.require(:screenshotreq).permit(:name, :urls)
    # Enable the create method to save screenshot requests with 
    # name and urls params.
  end

  def parse_urls
    # parse_urls method that takes an input of a string of semicolon 
    # delimited URLs, and assigns each individual URL in the list to 
    # a separate Screenshot instance.

    urls = []
    urls.push(@screenshotreq.urls.gsub(/\s+/, ''))
    # Puts URLs string into an array and removes any whitespace from string.

    urls_split = urls[0].split(';')
    # Turns the URLs string into an array of single URL strings.

    counter = 1
    urls_split.each do |url|
      image_path = "./storage/req#{@screenshotreq.id}shot#{counter}.png"
      image_file_name = "req#{@screenshotreq.id}shot#{counter}.png"
      @screenshot = Screenshot.create(url: url, image_file_path: image_path, image_file_name: image_file_name)
      @screenshot.screenshotreq = @screenshotreq
      @screenshot.save!
      counter += 1
    end
    # saves each individual URL from the list of URLs into separate 
    # Screenshot instances. Url is the parameter used by the screenshot 
    # capture method which determines the webpage to screenshot, image_file_path 
    # is the location where the image file of the screenshot will be stored, and
    # image_file_name is the name of the image file.
  end

  def create_screenshots
    # create_screenshots uses helper methods provided by the Webshot Gem 
    # to obtain image files of screenshots at specified URLs.

    ws = Webshot::Screenshot.instance
    # Instantiate an instance of Webshot.

    @screenshotreq.screenshots.each do |screenshot|
      ws.capture screenshot.url, screenshot.image_file_path, width: 1024, height: 768
      screenshot.image.attach(io: File.open(screenshot.image_file_path), filename: screenshot.image_file_name)
      # Use the ws.capture helper method to capture each screenshot 
      # associated with the screenshotreq instance. Inputs for the 
      # capture include the screenshot URL and the image path where 
      # the image will be saved. Finally, the new screenshot image is 
      # associated with the screenshot instance using the .attach method
      # native to Rails Active Storage.
    end

    flash[:notice] = 'The screenshots have been caputured and saved.'
  end
end
