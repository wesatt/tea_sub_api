# Tea Subscription Service API
This project was built over a few days, about 8 hours total, as part of a final assessment at [Turing School of Software and Design](https://turing.edu/).

The core goals of this project are to show:
- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

Once the setup instructions below have been completed you will be able to make API calls to:
- An endpoint to subscribe a customer to a tea subscription
- An endpoint to cancel a customer’s tea subscription
- An endpoint to see all of a customer’s subsciptions (active and cancelled)


## Prereqs
Built with:
  - Ruby 2.7.4
  - Rails 5.2.8.1
  - RSpec 3.11


## Setup
1. Ensure that you have the prerequisites or equivalent
2. Clone this repo and navigate to the root folder `cd tea_sub_api`
3. Run `bundle install`
4. Run `rails db:{drop,create,migrate,seed}`
5. (Optional) To run the test suite, run `bundle exec rspec`
6. Run `rails s`

You should now be able to hit the API endpoints using Postman or a similar tool.
Default host is `http://localhost:3000`


## Database Schema
![Database Schema Image](/images/tea_sub_api_schema.png "Database Schema Image")


# Endpoints

## Subscribe a customer to a tea subscription
### POST /api/v1/customers/1/subscriptions
- Required Params
  - `title`, `price`, `frequency`, `tea_id`
  - Send required data in JSON format in the body of the request as displayed in the example below
- Example Request
  - `POST http://localhost:3000/api/v1/customers/1/subscriptions`
  ```ruby
  body: {
    "title": "Single Tea",
    "price": 1000,
    "frequency": 4,
    "tea_id": 1
  }
  ```
- Example Response
  ```JSON
  {
      "data": {
          "id": 8,
          "type": "subscription",
          "attributes": {
              "title": "Single Tea",
              "price": 1000,
              "status": "active",
              "frequency": 4,
              "customer_id": 1,
              "tea_id": 1
          }
      }
  }
  ```
<br></br>

## Cancel a customer’s tea subscription
### DELETE /api/v1/customers/1/subscriptions/1
- Required Params
  - N/A
- Example Request
  - `DELETE http://localhost:3000/api/v1/customers/1/subscriptions/1`
  - Does not remove record, just changes status to cancelled.
- Example Response
  ```JSON
  {
      "data": {
          "id": "1",
          "type": "subscription",
          "attributes": {
              "title": "Captain's Choice",
              "price": 1000,
              "status": "cancelled",
              "frequency": 4,
              "customer_id": 1,
              "tea_id": 3
          }
      }
  }
  ```
  <br></br>

## See all of a customer’s subscriptions (active and cancelled)
### POST /api/v1/customers/1/subscriptions
- Required Params
  - N/A
- Example Request
  - `GET http://localhost:3000/api/v1/customers/1/subscriptions`
- Example Response
  ```JSON
  {
      "data": [
          {
              "id": "1",
              "type": "subscription",
              "attributes": {
                  "title": "Captain's Choice",
                  "price": 1000,
                  "status": "cancelled",
                  "frequency": 4,
                  "customer_id": 1,
                  "tea_id": 3
              }
          }, ...
      ]
  }
  ```
