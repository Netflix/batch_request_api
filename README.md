# batch_request_api

[![NetflixOSS Lifecycle](https://img.shields.io/osslifecycle/Netflix/osstracker.svg)]()

Rails middleware gem to achieve Batch creates, updates and deletes.

  * Customizable middleware
  * Batch create, update and delete records sequentially or in parallel

### Installation

  Add this line to your application's Gemfile:

  ```ruby
  gem 'batch_request_api'
  ```
  Or install it yourself as:

      $ gem install batch_request_api

### Overview

After installing the gem, you get the middleware which will intercept requests to the following urls.

  * batch_sequential ```(/api/v1/batch_sequential)```
  * batch_parallel ```(/api/v1/batch_parallel)```

### Sequential Usage

This is the simplest way to implement batch. One network request to ```/api/v1/batch_sequential``` containing the batched payload will work with a regular rails controller.

### Parallel Usage

This requires your controller to iterate and apply a transaction. One network request to ```/api/v1/batch_parallel``` containing the batched payload will need a code similar to this [sample](https://github.com/Netflix/batch_request_api/blob/master/docs/sample_parallel_controller.md).

The batch request payload is available on the controller using ``` params['json'] ```

### Batch Client

* [Ember Addon](https://github.com/Netflix/ember-batch-request) (Ideal)
* [Ruby Client](https://github.com/Netflix/batch_request_client)

We expect that you will probably use the [Ember Add on](https://github.com/Netflix/ember-batch-request) with this gem to make the batch request and receive a response.

If not, no worries we have built a [sample Ruby Client](https://github.com/Netflix/batch_request_client) for you on this gem.

Here are the sample payloads that the middleware expects for [create/update/delete](https://github.com/Netflix/batch_request_api/blob/master/docs/expected_middleware_payload.md).
The ruby client constructs the format for create action.

### Batch Request Payload:

```javascript
"requests": [
    {
      "method": "POST",
      "url": "/api/v1/movies",
      "body": { }, { }
    }
  ]
}
```

### Batch Request Response:

```ruby
[
  {"status"=>200, "headers"=>{}, "response"=>{}},
  {"status"=>200, "headers"=>{}, "response"=>{}}
]
```


### Contributing

If you would like to contribute, you can fork the project, edit, and make a pull request.
