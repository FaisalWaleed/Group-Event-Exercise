# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    2.7.0

* Setup Instructions
  In the root directory run
    `yarn install`
    `bundle install`
    `rails db:create`
    `rails db:migrate`
    `rails server`
  and boom you are running the server

* How to run the test suite
  run command `rspec` in root directory

* API instructions
    I have created a postman collection below is the link
    `https://documenter.getpostman.com/view/13366804/TVYPztiM`


### Assumptions
  For the project I have taken following assumptions

  1- As there was no authentication, so I added a secret to each group event.which is used for editing/deleting the group event. It is inputted by user at the time of creation of group event.`So that we can ensure authorization i-e user1 can not delete/edit user2's event because it is protected by secret :) `

  2- Assumed that every user can see anyone's event.

