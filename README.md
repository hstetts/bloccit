# Bloccit: A Replica of Reddit

* Visit [Bloccit](https://obscure-brushlands-82348.herokuapp.com/)

## Functionality:

* User can sign up for an account with a username, password, and email address
* User can sign in and out
* User can be a guest or sign up to be a member with more access rights
* User can create topics, posts, comments
* User can favorite posts and track new comments on them
* User can add comment to a post without refreshing the page
* User can edit/delete topics, posts, and comments her or she created
* Admin role can create/edit/delete any topics, posts, or comments

## Run Locally:

1. Clone the repository
2. Run bundle install
3. Create and migrate the SQLite database with rake db:create and rake db:migrate
4. Start the server: 'rails s'
5. Run the app on localhost:3000
