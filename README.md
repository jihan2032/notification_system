# Notification System
Communication tool that allows creating different type of notifications(group/personalized) and sending them to the targeted users via various number of service-providers

## Built With
- [Ruby on Rails](https://guides.rubyonrails.org/index.html) framework
- [Mini Test](https://guides.rubyonrails.org/testing.html#rails-meets-minitest) testing framework
- [MYSQL](https://dev.mysql.com/doc/mysql-getting-started/en/) database
- [Sidekiq](https://github.com/mperham/sidekiq) background processing framework
- [Redis](https://redis.io/) data store
- [Rubocop](https://github.com/rubocop-hq/rubocop) code linter
## Getting Started

### Prerequisites
You will only need to install [docker](https://docs.docker.com/engine/install) and make sure it is running on you machine

### Usage
Create the database  
`docker-compose run api rails db:create`  

Run the application  
`docker-compose up`  
And in another terminal run  
`docker-compose run api sidekiq`  

## Development
Seed some ready data if needed  
`docker-compose run api rails db:seed`  

Make sure your code is well formatted  
`docker-compose run api rubocop`  

## Test
Make sure test cases are passed  
`docker-compose run api rails test`  

You can run a specific test file or directory  
`docker-compose run  api rails test -b test/models/user_test.rb`  

## API Reference
Documented by postman [here](https://documenter.getpostman.com/view/11605365/SztHYRZa?version=latest)

## Architecture and Schema

### Users
- Represent the recipients of notifications
- Have a perferred language in which he/she will receive his/her notifications

### Languages
- Represent all supported languages in the app
- Every user must have a preferred language in which he/she will receive his/her notifications, we make sure of that by: 
&nbsp; - depending on the `texts` attribute in the `notification` model,`texts` is a hash where the keys are valid language codes (from the ones saved in the DB) and the hash values represent the notification's content translated in these languages, so when firing notifications: each user_notification will have the translated content according to the user's perferred language
&nbsp; - every notification must also have a `default_lang` value which used in case the notification texts hash doesn't include the user's language (to support flexbility when adding new languages while firing old notifications and other similar cases)
&nbsp; - we also flag such notifications (sent in a different language other than the user's perferred one) by a boolean named `incrorect_lang` to track such cases for reporting and maybe resending them again after adding the missing translations

### Notifications
- Created by application admins with the desired attributes
- Can be group or personalized, personalized ones could hold the user's first name in their content
- Same notifications can be sent to different users at different times

### User Notifications
- Created when application admins fire a specific notification to 1 or more users
- Represent the middle table of the many-to-many relation between notifications and users
- Holds the translated content of the notification according to the user's perferred language

### Providers:
- Represent the third-party services needed in firing notifications
- `provider.rb` is the superclass (STI) of 3 sub-classes(`sms.rb`, `email.rb`, `push_notification.rb`): each one holds the integration code for this specific provider inside a method named `send_notification(content:, user_id:)`
- provider model raises exception inside it's version of `send_notification(*)` to make sure every newly created sub-class implements it
- provider model also handles the api-limit on requests by:
&nbsp; - saving the values of 2 attributes (`last_sync`:  timestamp of the last time the provider requested it's api, `last_min_count`: count of requests sent within the last min of integration)
&nbsp; - for example if the sms provider api limit is 1000 request per min and we requested to send a notification for 2000 users at once, then firing the notifications will go smoothly in the background updating the above attributes till the `last_min_count` reaches 999 then it will reschedule the rest of the notifications to be executed after a minute, and also after passing the min we will check again (and reschedule) in case another notification is fired on another process using the same provider, thus have many jobs in the queue.

## Possible Improvments
- [Sidekiq API-limit](https://github.com/mperham/sidekiq/wiki/Ent-Rate-Limiting) enterprise integration for better handling of the providers api-request limits
- Decoupling the provider from the notification to allow more flexible design, where same notification can be sent different times using different providers

## Assumptions
- User authorization is out of the task's scope
- Admin authorization is done using [BasicAuth](https://api.rubyonrails.org/classes/ActionController/HttpAuthentication/Basic.html) for simplicity
- Some validations are out of the task's scope, since it depends on business requirments like validating the email or users can sign-up with only their phone, also use a passowrd or just the verification code, etc
- Other cruds should be implmented like (languages, users, providers, etc) and their data should be used when creating notifications, for example the `provider_id` needed to create a notification
