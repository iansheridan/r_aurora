# RAurora

This gem provides a simple ruby interface to work with the Aurora OpenAPI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'r_aurora'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r_aurora

## Usage

Install the gem:
`gem install r_aurora`

Assuming you already have retrieved your api token
Define the following parameters

`base = 'http://10.0.1.72'` #put your aurora IP addres here

`api = 'api/v1/'`

`token = "51zzxpyupomWxisLiyjcVupDLINqqdHL/"` #note the trailing slash...

Instantiate the class

`aurora = RAurora::Base.new(base, api, token)`

1. the first parameter is the request type.  Typically `get` or `put`.

2. the second parameter below represents the node of the JSON structure as defined in the Open API docs. In this case `state/`

3. The third parameter is the json payload, if needed, to pass with the request.

```ruby
request_type = "put"
payload = {"on": {"value": false}}
aurora.on(request_type, "state/", payload)
```

I used method_missing to synthesize the endpoint. This drastically reduced code duplication but I may change this in the future.  You simply call the endpoint name as a method on the instance and it will auto generate the correct format for the request.  You just need to use underscores in place of camelcase.  For example the endpoint in the API is `rhythmConnected` so you would try to call `rhythm_connected` on the instance.  See examples below.

For example

`request_type = "get"`

`aurora.rhythm_connected(request_type, "rhythm/")`

returns `"200"
=> "true"`

`aurora.hardware_version(request_type, "rhythm/")`

returns `"200"
=> "\"1.4\""`

`aurora.ct(request_type, "state/")`

returns `"200"
=> {"value"=>4300, "max"=>6500, "min"=>1200}`


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stevestofiel/r_aurora.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
