# ActionService v1.0
Welcome to Action Service gem, is a ruby gem to create and interact easily with services.

## Why services
Is where you can add your code to perform simple functionality instead of making complex controllers or models.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'action_service'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install action_service
```

## Setting up
For start to use the gem execute:
```bash
$ rails g service:application_service
```
This command will generate application service (is the parent class for all your services), application service is inheriting from the action service base class, and you can overwrite all methods.

## Usage
You can start to use action service by generating service to execute a specific logic, Example:
Run next command to generate service for authenticating an admin
```bash 
$ rails g service Admin::Authenticate
```
this will add a new directory for admin inside `app/services` if not exist, and generate `authenticate_service.rb`
```bash
Running via Spring preloader in process 30051
      create  app/services/admin/authenticate_service.rb
```
And when you open `authenticate_service.rb` will be like this
```ruby
class Admin::AuthenticateService < ApplicationService

    def initialize()
        super()
    end

    def call
        return self
    end

end
```

### ApplicationService class
All generated services are inhariting from `ApplcaitonService`, `ApplicationService` is inherite from `ActoinService::Base, So all service will contain:  
#### Three instance variables 
1. `@success` is a boolean with `true` as default value , and if you add any error this flag will be changed to `false`. 
2. `@errors` is a array contain a list if errors.
3. `@response` is a hash to add service response (values, objects, etc.).
#### Six instance methods
1. `success?` to get boolean if service excuted successfully ot not (based on adding errors).
2. `errors` to get list of errors.
3. `response` to get response hash.
4. `add_error(error_message)` to add error (will change `@success` to `false`), Example `add_error("wrong admin id")`.
5. `add_errors(*error_messages)` to add errors as parameters or array (will change `@success` to `false`), Example `add_errors("email is required","phone number is aready exist")` OR `add_errors(["email is required","phone number is aready exist"])`.
6. `add_errors_array(error_messages_array)` to add array of errors (will change `@success` to `false`), Example `add_errors_array(["email is required","phone number is aready exist"])`.

Now, let's implement `Admin::AuthenticateService`
```ruby
class Admin::AuthenticateService < ApplicationService

    def initialize(email, password)
        super()
        @admin = Admin.find_by(email: email)
        @password = password
    end

    def call
        add_error "wrong admin email" and return self if not @admin
        add_error "wrong password" and return self if not @admin.authenticate(@password)
        @response[:admin] = @admin
        return self
    end
end
```

This service is now ready to be used, For example we will call the service inside a controller
```ruby
result =  Admin::AuthenticateService.new(params[:email], params[:password]).call
if result.success?
    # {success: true, response: {admin object}, errors: []}
    render json: { success: result.success?, response: result.response, errors: result.errors }
else:
    # {success: false, response: {}, errors: ["wrong email" OR "wrong password"]}
    render json: { success: result.success?, response: result.response, errors: result.errors }, status: :unauthorized
end
```

#### Services layer will help you to write clean code, by small models, controller and DRY code (don't repeat yourself), you can use service inside another service and stop excuting the first service if the second one fails, Example:
```ruby
class Cache::List::AddHashService < ApplicationService

    def initialize(list_key, hash_key, hash_data, expiry_datetime=nil)
        super()
        @list_key = list_key
        @hash_key = hash_key
        @hash = hash_data
        @expiry_datetime = expiry_datetime
    end

    def call
        result = Cache::Hash::SetService.new(hash_key, hash_data, @expiry_datetime).call
        # if Cache::Hash::SetService fails will stop excuting and return the errors
        add_errors result.errors and return self if not result.success? 
        result = Cache::List::AddService.new(list_key, hash_key, @expiry_datetime).call
        # if Cache::List::AddService fails will stop excuting and return the errors
        add_errors result.errors and return self if not result.success?
        self
    end
end
```

## Troubleshooting 
In case your Rails app can't access the services directory and showing an error like `uninitialized constant ServiceName` you can solve it by adding `app/services` to `config/spring.rb`

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/abdofawzi5/action_service](https://github.com/abdofawzi5/action_service). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
