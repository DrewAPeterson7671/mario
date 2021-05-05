# _Mario's Speciality Food Products_

#### _Application to list products and reviews, 1/17/2020_

#### By _**Drew Peterson**_

## Description

_This Application is a marketplace for users to rate the products of an exotic food importer:_

* Create from scratch Ruby/Rails app for a food importer showcasing their imported products.
* Create a system were users can review and rate products.
* Create an authentication system for users to log in.
* Authorization functionality for admin users and hidden admin functionality.
* Users can post reviews and ratings of products.
* Admin users have full CRUD functionality.
* Users have CRUD functionality for their own review posts.
* Reviewers can upload avatars to Active Storage on AWS S3.
* Admin users can upload images of the new products they create to Active Storage on AWS S3.
* Product and Review pages can be sorted to display by highest ratings, alphabetical and many other display options.
* Home page includes scopes showcasing hightest reviewed, most reviewed, and newest products.
* Highest Rated, Most Reviewed and New products have corner sashes.
* Search bar with links to search results.
* The website is responsively designed to function on mobile viewports.

_See the deployed app on Heroku: https://marios-specialty-foods.herokuapp.com/_

## Setup/Installation Requirements

* Requires Ruby 2.6.5, Rails 5.2.4 and PostgresQL. 
* Clone the project locally from github.
* Install Bundler to your environment if you do not already have it.
* Run bundle install to manage gems; if you make additional changes to the Gemfile, you will need to run this command again.
* DATABASE INSTRUCTIONS - from terminal in the the root directory of this project, run these commands:
*   rake db:create
*   rake db:migrate
*   rake db:seed
* Product environment Active Storage requires configuration of AWS S3.  Development environment will store content locally.
* Open a terminal and type "rails s"
* Open a web browser to https://localhost:3000.

## Known Bugs

_This site is hosted on the free Heroku service, so the dynos that run it go to sleep until the site is accessed.  So the first load is slower than when the dyno awakens.  This isn't a bug as much as a budget constraint._

_All images of products and reviews are hosted on S3 except for about 3% of them.  This is done per the true use case that both the vendor and users would upload all images to S3.  All initial product and reviewer avatar images could have been loaded to Heroku to boost speed, but would be window dressing, in my opinion. It would be untrue to the use case.  S3 images load slower, but this app is fully functional to the true use case. This is not a bug as much as a choice of realism over cheating for a faster load of the presentation._

_When a user uses a sort of a product or review, and then clicks on an individual product or review, the next and previous buttons will take the user to the next product review or product ID without considering what was next in that list sort.  For example, if they list products by alphabetical order, click on Almonds and view the Almonds page, the next and previous buttons will take them to a product, but not the next in alphabetical order._

## Support and contact details

_Please contact me directly via email at drew.a.peterson@hotmail.com with any bug reports, questions, critique, or for any reason._

## Technologies Used

_Ruby 2.5.1, Rails 5.2.4, Postgres SQL, Heroku, AWS S3, Rails Active Storage, SCSS_

### License

*GPL*



Copyright (c) 2021 **_Drew Peterson_**

