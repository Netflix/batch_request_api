Create:

  ```javascript {
    "requests": [
      {
        "method": "POST",
        "url": "/api/v1/movies",
        "body": {
          "data": {
            "attributes": {
              "name": "The Zen Monk",
              "year": 2015
            },
            "relationships": { },
            "type": "movies"
          }
        }
      },
      { }
    ]
  }
  ```

Update:

  ```javascript {
    "requests": [
      {
        "method": "PATCH",
        "url": "/api/v1/movies/1",
        "body": {
          "data": {
            "attributes": {
              "name": "The Zen Monk",
              "year": 2015
            },
            "relationships": { }
            },
            "type": "movies"
          }
        }
      },
      { }
    ]
  }
  ```

Delete:

  ```javascript {
    "requests": [
      {
        "method": "DELETE",
        "url": "/api/v1/movies/11111",
        "body": "11111"
      },
      {
        "method": "DELETE",
        "url": "/api/v1/movies/22222",
        "body": "22222"
      }
    ]
  }
  ```
