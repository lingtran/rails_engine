## Synopsis
Designed and versioned API using Ruby and ActiveRecord to perform complicated business intelligence. Built Single-Responsibility controllers with tests.

## Motivation

Learn how to build Single-Responsibility controllers to provide a  well-designed and versioned JSON API. Learned how to be test-driven with controllers to inform design. Learn to user Ruby and ActiveRecord to perform complex business intelligence.

  * [Project Spec](https://github.com/lingtran/rails_engine/blob/master/project-spec.md)
  * [Project Eval](https://github.com/lingtran/rails_engine/blob/master/rails-engine-eval.md)

## Tech Stack

##### Back-end
> Ruby | Ruby on Rails | PostgreSQL

## Getting Started

##### Clone git repo
  * ``git clone https://github.com/lingtran/rails_engine.git``

##### Bundle install dependencies
  * ``bundle``

##### Setup database
  * ``rake db:reset``

##### Import data
  * ``rake import_data:all``
    * If the task for single load above does not work, individually ``rake`` task in the following order:

      * ``rake import_data:customers``
      * ``rake import_data:merchants``
      * ``rake import_data:invoices``
      * ``rake import_data:items``
      * ``rake import_data:invoice_items``
      * ``rake import_data:transactions``


##### Root API endpoint
  > http://localhost:3000/api/v1/

  > Run server `rails s` before visiting endpoints

  > Reference [API Endpoints](#api-endpoints) to access list of endpoints

## API Endpoints
  * [API Reference](https://github.com/lingtran/rails_engine/blob/master/api-reference.md)

## Tests
Test suite: RSpec | Factory Girl | Capybara | Database Cleaner

Created 203 tests with helpers and test data.

> `rspec`
