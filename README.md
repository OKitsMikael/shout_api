# ShoutApi

## Endpoints
Headers:  
`Content-Type: application/json`

`POST shout-api.herokuapp.com/api/sign_up`

```JSON
{
  "user": {
    "username": "testguy",
    "email": "testguy@test.com",
    "password": "password",
    "password_confirmation": "password"
  }
}

```

Response:
```JSON
{
  "data": {
    "user": {
      "username": "testguy",
      "email": "testguy@test.com"
    },
    "jwt": "<jwt>",
    "exp": "1481672078"
  }
}
```

`POST shout-api.herokuapp.com/api/login`

```JSON
{
  "user": {
    "email": "testguy@test.com",
    "password": "password"
  }
}
```
Response:
```JSON
{
  "data": {
    "user": {
      "username": "testguy",
      "email": "testguy@test.com"
    },
    "jwt": "<jwt>",
    "exp": "1482167450"
  }
}
```



`GET shout-api.herokuapp.com/api/logout`

Headers: 
`Authorization: Bearer <jwt>`

----
To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
