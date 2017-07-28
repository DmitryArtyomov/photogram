# Technical task:

The project is a simple analog of Instagram. The basic functionality of the application includes the following functions:

- Registration of users in the system. User profile.
- User albums. CRUD operations on albums and photos
- Tags
- Subscriptions to other users
- The main page of the site - the feed of the latest photos from the subscriptions
- Comments on photos
- Global search across the application - the ability to search by album names, tags, users (search - through AJAX with suggested word variants)
- Authorization system (CanCanCan), roles and - permissions
- Sending email notifications
- Logging at the middleware level
- Configuring the scripts for deploy
- Configuring nginx
- Using twitter-bootstrap for page layout
- Using active-admin for admin
- Writing tests (rspec, rspec-it, - shoulda-matchers, simplecov)
- Setting up environments for production, test, - development
- Using Action Cable to Push Notifications

## Part 1.

- Designing, highlighting the entities of the domain. Identify the relationships between entities in the system. Designing a relational model.
- Description (generation) of key entities in the system in the form of models and controllers.

## Part 2.

- Creating a user model. The model includes first name, last name, email, avatar, address. The first name, last name, email fields are required.
- Realization of albums. Each album has a title, tags and a small description. The album name is required. Contains photos of the user in an amount not more than 50 photos. Only the owner has the rights to edit the album, viewing the content - all users. On the main album page all photos are shown in a condensed form.
- Implementation of the model of photos. The photos contain tags, a short description and a list of comments. The ability to edit photos is owned only by their owner. The size of the photo should not exceed more than 20mb.
- Tags. Used for albums and user photos. All tags must begin with a \# character and not exceed a limit of 20 characters. It is permissible to use only numbers and symbols of the alphabet.
- Comments. Applied to photos, do not exceed the limit of 140 characters.

## Part 3. Graphical interface

Implementation through server-side rendering. You can use simple js libraries (jQuery). For styles, use Bootstrap or any wrappers above it

## Part 4. Use cases
### Homepage
The main page of the site is a feed of the most recently added custom photos. Above each photo there is a user name (a link to his profile) with a photo and an album name (link to the album). By clicking on the photo it opens in full size in the pop-up window. In the right part of the screen there is a column with comments (user avatar, name, date of adding the comment itself). The comments are displayed in chronological order, at the bottom there is a comment entry box and a submit button.

### Profile page
The page displays all the public albums of the user. The sketch uses a collage of photos, under which there is a link to the album.

### Album page
The page displays thumbnails of the photos. By clicking on the photo, its full-sized representation opens with the same representation like on the main page.
