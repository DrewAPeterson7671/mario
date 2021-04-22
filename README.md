# _Mario's Speciality Food Products_

#### _Application to list products and reviews, 1/17/2020_

#### By _**Drew Peterson**_

## Description

_This Application is a marketplace for users to rate the products of an exotic food importer:_

* Create from scratch Ruby/Rails app for a food importer showcasing their imported products.
* Create a system were users can review and rate products.
* Create an authentication system for users to log in.
* Include functionality for admin users and hidden admin functionality.
* Admin users should be able to creation, edit and delete products.  They can also mediate reviews by editing and deleting them.
* Reviewers can upload avatars to Active Storage on AWS S3.
* Admin users can upload images of the new products they create to Active Storage on AWS S3.
* Create functionality for users to submit reviews for each product listed.
* Home page includes scopes showcasing hightest reviewed, most reviewed, and newest products.
* Search bar with links to search results.
* Provide a Capybara test suite.

_to list products and reviews including CRUD functionality with authentication and admin permissions._

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

_This site is not yet optimized for mobile.  There is an issue with grid on the product list pages and home page where the items overflow the grid._

## Support and contact details

_Please contact me directly via email at drew.a.peterson@hotmail.com with any bug reports, questions, critique, or for any reason._

## Technologies Used

_Ruby 2.5.1, Rails 5.2.4, Postgres SQL, Heroku, AWS S3, Rails Active Storage_

### License

*GPL*



Copyright (c) 2021 **_Drew Peterson_**

