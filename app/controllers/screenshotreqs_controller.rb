class ScreenshotreqsController < ApplicationController
  # Screenshot requests (Screenshotreqs for short) Controller.  
  # This is the main controller for the application that governs CRUD
  # functions for Screenshot requests and Screenshots.
  
  def index
    # index method sends all screenshot request params to the front page: 
    # ./app/views/screenshotreqs/index.html.erb
    
    @screenshotreqs = Screenshotreq.all
  end
  
  # Do I need this method??
  def new
    @screenshotreq = Screenshotreq.new
  end

  def create
    # Create method creates a new instance of a Screenshot Request 
    # to be populated with data submitted from the form in new.html.erb.  
    # When the "submit request" button on the form is clicked, the method 
    # attempts to save the screenshotreq. If the new screenshotreq meets 
    # the validation criteria in ./app/models/screenshotreq.rb, then .save 
    # is successful and parse_urls and create_screenshots methods are run.  Also
    # after save, the view redirects to the home page.
    
    @screenshotreq = Screenshotreq.new(screenshotreq_params)
    
    if @screenshotreq.save
      parse_urls
      # parse URLs
      
      create_screenshots
      # create and save screenshots

      redirect_to root_path
      # Redirect view to home page after save
    end
  end

  def show
    # show method reads the information of a previously saved screenshot 
    # request in the database, and sends that information to a new view 
    # page defined by ./app/views/screenshotreqs/show.html.erb. The particular 
    # screenshotreq read from the database is identified by id parameter.

    @screenshotreq = Screenshotreq.find(params[:id])
  end

  private
  # private methods (below this point) not accessible from calls outside 
  # of this controller.

  def screenshotreq_params
    # screenshot_params method is used to enable the create method to 
    # save screenshot requests with name and urls params.

    params.require(:screenshotreq).permit(:name, :urls)
  end

  def parse_urls
    # parse_urls method that takes an input of a string of semicolon delimited URLs,
    # and assigns each individual URL in the list to a separate Screenshot instance.

    urls = []
    urls.push(@screenshotreq.urls.gsub(/\s+/, ""))
    # Puts URLs string into an array and removes any whitespace from string

    urls_split = urls[0].split(";")
    # Turns the URLs string into an array of single URL strings

    counter = 1
    urls_split.each do |url|
      @screenshot = Screenshot.create(url: url, img_path: "./storage/req" + @screenshotreq.id.to_s + "shot" + counter.to_s + ".png", img_path_short: "req" + @screenshotreq.id.to_s + "shot" + counter.to_s + ".png")
      @screenshot.screenshotreq = @screenshotreq
      @screenshot.save!
      counter += 1
    end
    # saves each individual URL from the list of URLs into separate Screenshot instances.
    # url is the parameter used by the screenshot capture method which determines the webpage to screenshot,
    # img_path is the location where the image file of the screenshot will be stored, and
    # img_path_short is the name of the image file.

  end

  def create_screenshots
  # create_screenshots uses helper methods provided by the Webshot Gem to obtain
  # image files of screenshots at specified URLs.

    ws = Webshot::Screenshot.instance
    # instantiate an instance of Webshot

    @screenshotreq.screenshots.each do |screenshot|
      ws.capture screenshot.url, screenshot.img_path, width: 1024, height: 768
      screenshot.image.attach(io: File.open(screenshot.img_path), filename: screenshot.img_path_short)
    end
    # use the ws.capture helper method for each screenshot for an associated screenshotreq,
    # at the specified URL, giving the image the img_path file name.

    flash[:notice] = 'The screenshots have been generated and saved.'
  end
end
