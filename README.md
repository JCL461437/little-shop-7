# Little Esty Shop

## Database Schema
<img width="1314" alt="NEWDBSCHEMA" src="https://github.com/JCL461437/little-shop-7/assets/74687494/35d2668f-755b-48cf-941d-9e2a13117917">

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Collaborators 
- Austin Carr-Jones, https://github.com/austincarrjones
- Jan Lehigh, https://github.com/JCL461437
- Lance Nelson, https://github.com/LancePants97
- Garrett Bowman, https://github.com/GBowman1

## Heroku App
https://fathomless-sea-25232-ffc29695f369.herokuapp.com/

## Ideas for a potential contributor to work on/refactor next
- Update admin/merchants Top Merchants. Date is printing current date/time.
- Welcome Page, create a form to enter a Merchant id to a merchant show page.
- Match more views to wireframes using CSS.
- Create more sad path/edge case tests.
- Create destroy actions where appropriate.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- [Optional] Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- Must use Rails 7.1.x, Ruby 3.2.2
- Must use PostgreSQL
- All code must be tested via feature tests and model tests, respectively
- Must use GitHub branching, team code reviews via GitHub PR comments, and either GitHub Projects or a project management tool of your group's choice (Trello, Notion, etc.)
- Must include a thorough README to describe the project
   - README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project. 
- Must deploy completed code to the internet (using Heroku or Render)
- Continuous Integration / Continuous Deployment is not allowed
- Use of scaffolding is not allowed
- Any gems added to the project must be approved by an instructor
  - Pre-approved gems are `capybara, pry, faker, factory_bot_rails, orderly, simplecov, shoulda-matchers, launchy`

## Setup

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)
