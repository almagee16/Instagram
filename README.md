# Project 3 - *Instagram*

**Name of your app** is a photo sharing app using Parse as its backend.

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [ x ] User can sign up to create a new account using Parse authentication
- [ x ] User can log in and log out of his or her account
- [ x ] The current signed in user is persisted across app restarts
- [ x ] User can take a photo, add a caption, and post it to "Instagram"
- [ x ] User can view the last 20 posts submitted to "Instagram"
- [ x ] User can pull to refresh the last 20 posts submitted to "Instagram"
- [ x ] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [ x ] Style the login page to look like the real Instagram login page.
- [ x ] Style the feed to look like the real Instagram feed.
- [ x ] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs - [ x ] for Home Feed and Profile
- [ ] Add a custom camera using the CameraManager library.
- [ x ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [ x ] Show the username and creation time for each post
Hint: If you use TableView Section Headers to display the the username and creation time, you'll get "sticky headers" - [ ] similar to the actual Instagram app.
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
- [ x ] Allow the logged in user to add a profile photo
- [ x ] Display the profile photo with each post
- [ x ] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [ ] User can like a post and see number of likes for each post in the post details screen.
- [ x ] Run your app on your phone and use the camera to take the photo


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I think it would be better if I were able to make my UI look a little bit better and improve the overall look of the app. 
2. I think it would be really cool to create my own camera interface as the stock camera does not look as good as some of the other cameras that can be created from scratch. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/lVkVTp8.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library


## Notes

Describe any challenges encountered while building the app.

Adding new features is pretty difficult because you have to account for the fact that some users my not use the new feature. For example, I added the profile picture, and set a default profile picture for each subsequent user, however, I had to do special things for the users that were created before I added this feature. 


## License

Copyright [yyyy] [name of copyright owner]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
