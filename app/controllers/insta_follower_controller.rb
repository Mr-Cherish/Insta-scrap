#require 'webdrivers'
require 'watir'
require 'chromedriver/helper'
require 'open-uri'
require 'webdrivers'
require 'nokogiri'

class InstaFollowerController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def find_followers
	  	attempts = 0
	  	begin

	  	#Open browser which will controlled by our code. (Browser options are :chrome, :safari , :firefox)
      opts = {
        headless: false
    }

      if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
        opts.merge!( options: {binary: chrome_bin})
      end

      browser = Watir::Browser.new :chrome, opts
	  	#browser = Watir::Browser.new :firefox

	  	#Open classic login page of instagram.
		browser.goto("https://www.instagram.com/accounts/login/?force_classic_login")

		#Enter username & password in the form fields.
		username = browser.text_field(id: "id_username").set(Rails.application.credentials.instagram_username)
		password = browser.text_field(id: "id_password").set(Rails.application.credentials.instagram_password)

		#Click Login button.
		browser.input(class: 'button-green').click

		sleep(1)

		#Open user profile page.
		browser.goto("https://www.instagram.com/#{params["uid"]}/")
		sleep(1)

		#Handling private account situation.
		@private_acc = browser.h2s(class: "rkEop").first.exists?
	  	if @private_acc
	  		@prvt = true;
	  	else

			if params["mode"] == "Followers"
				browser.as(class: "-nal3").first.click
			else
				browser.as(class: "-nal3")[1].click
			end
			sleep(3)

			#Loop to scroll the followers/followings modal till we get desired number of accounts.
			# i = 1
			# loop do
			# browser.driver.execute_script("document.querySelector('body > div.RnEpo.Yx5HN > div > div.isgrP').scroll(0,(60 * #{i}))")
			# i+=1
			# break if browser.as(class: "FPmhX").count >= params["total"].to_i
			# sleep 0.1
			# end

			#passing webpage code to Nokogiri.
			document = Nokogiri::HTML(browser.html)

			#Scrapping data from webpage using css selector of Nokogiri.
			@nodeset = document.css('a[href].FPmhX')
			@realnames = document.css('div.wFPL8')
			@pics = document.css('img._6q-tv')
			end
		end

		#Closing the browser after our work is finish.
		browser.close

		#Handling TimeOut error
		rescue Net::ReadTimeout => e
		if attempts == 0
		  attempts += 1
		  retry
		else
		  raise
		end
  end
end
