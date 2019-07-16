# Insta-scrap

Instagram followers and following scraping with Watir + Nokogiri.

## Introduction

This is Instagram followers and following scraper made in Ruby on Rails with Watir and Nokogiri gem.
As Nokogiri can't scrap data directly from JavaScript based website because, their contents are loaded asynchronously after some time.
So in this project watir helps us to fetch our page content once they are loaded on webpage, Another problem is Instagram open followers and following in Modal popup, so we have to scroll that popup till we get desired number of Account details. Here watir help us to scroll the modal popup by applying JavaScript to the site runtime.

## Instruction

To run this project we have to add one Instagram user credential.

Add your credentials in "/config/credentials.yml.enc" with following name
instagram_username
instagram_password

Or you can directly add the credential in "/controller/insta_follower_controller.rb" line number 23,24 for quick setup.
