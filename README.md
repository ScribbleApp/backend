

# Scribble (backend)

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites:
- ruby 3.0.0
- PostgreSQL 13.11 or later
- Rails 7.0.4.3

## Installing:
1) Clone repository:
   ```git clone https://github.com/Scribble/backend```

2) Build project:

To build the application execute the following commands in CLI in the project folder(.../backend):

- ``` rails db:create```  # this will create your database
- ``` rails db:schema:load```  # this will create columns in your database
- ``` rails db:seed```  # this will create mock data in database
- ``` bundle install```  # this will install required libraries

### Running the Application:
Now you can launch the server for example (default port is 3000) [http://localhost:3000](http://localhost:3000):

- ```rails s```

### Built With:
- Rails - Web framework

## Our team
* [Kyrylo Teplynskyi (Dev)](https://github.com/4Kirishy)
* [Ruslan Morozov (Dev)](https://github.com/Ruslanchik01)
* [Andrii Znayko (Dev)](https://github.com/ldaxss)


## Routes
### Маршрути для постів:
- get '/posts': отримати список усіх постів 
- get '/posts/:id': отримати деталі поста за заданим :id
- post 'posts': створити новий пост
- delete 'posts/:id': видалити пост за заданим :id 

### Маршрути для категорій:
- get 'posts/categories': отримати всі категорії постів
- post 'posts/categories': створити нову категорію
- delete 'posts/categories/:id': видалити категорію за заданим :id

### Маршрути для коментарів:
- get '/posts/:id/comments': oтримати всі коментарі для поста з заданим :id
- post '/posts/:id/comments': cтворити новий коментар для поста з заданим :id 
- delete '/posts/:id/comments/:com_id': видалити коментар з заданим :com_id для поста з заданим :id

### Маршрути для підписок:
- get 'subscriptions/:id': oтримати підписки користувача за заданим :id
- get 'subscribers/:id': oтримати підписників користувача за заданим :id
- post 'subscriptions': cтворити нову підписку
- delete 'subscriptions/:id': видалити підписку за заданим :id

## License
__©️ Karazin university__
