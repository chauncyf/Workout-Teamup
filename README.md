# Workout Teamup
This is a course project repository for COSI 166B
 
## Feature Overview
* Team-up flyer invitations and reminders
* User achievements
* Chatting function
* Location sharing function
* User account management
 
## Things you may want to cover
* Ruby version - 2.5.1 
* Rails version - 5.2.1
* Bootstrap - v4.1.x
* [Link to Heroku](https://teamup12341.herokuapp.com/)
* [Link to Trello](https://trello.com/b/pVBKKavl/teamup)
* Contributor: Xiangran, Limian, Chenfeng

## Tips
* Recreate db
``` 
$ rails db:drop db:create db:migrate
```
###### OR  
* Delete the entire contents on your db and recreate the schema from your schema.rb file, without having to apply all migrations one by one.
```
$ rails db:schema:load
``` 

* Params debugger
```
<%= debug(params) if Rails.env.development? %>
```