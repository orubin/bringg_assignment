# README

Comments and assumptions

* Ruby 2.5.3, Rails 5.2.3, started the project with --api
* access token and key are env params
* Tried to sign the calls and call Bringg's API - with no success, postman also
* Didn't check if a client already exists in the system - produced a new client and a new task for every API call to create an order
* Seperated the API module and URI signing module and other helpers - so they can be replaced and tested easily
* added some basic tests - controller and the module that handles the get tasks with paging
* made an assumption that the tasks returned from the API are ordered by date - next pages have older tasks

* "Regular" flow would be:
  * bundle install
  * rails test
  * rails s