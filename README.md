# TwitterClone

![TwitterClone Showcase May 23 single image 001](https://github.com/bodhichristian/TwitterClone/assets/110639779/b2225dc1-5ffe-4691-abb7-075ca4f8e107)

A functional clone of the app formerly known as Twitter. The interface is built entirely with SwiftUI, uses Firebase for authentication and storing user data, and follows MVVM archtitecture.

<b>Onboarding and Authentication</b>
![TwitterClone Showcase May 23 001](https://github.com/bodhichristian/TwitterClone/assets/110639779/352eb135-c49b-4d8c-9f10-6fb5c0ea39ff)
- Firebase is used to authenticate user sessions.
- Users may register for an account, and log in using email and password.
- Conditionally formatted buttons guide the user through the onboarding process.


<b>Feed, Side Menu, Compose Tweet</b>
![TwitterClone Showcase May 23 002](https://github.com/bodhichristian/TwitterClone/assets/110639779/112995fe-0eca-4b08-889b-458dc81ddc5d)
- Once authenticated, the app presents a tabbed interface, with the Home tab presenting a feed of tweets.
- A side menu is revealed when profile photo is tapped, providing user with navigation paths, and the ability to log out.
- Users may compose a new tweet, adding text and/or an image.


<b>Profile, Liked Tweets, Edit Profile</b>
![TwitterClone Showcase May 23 003](https://github.com/bodhichristian/TwitterClone/assets/110639779/fcee1496-927b-4092-b281-0d464224a48f)
- User profile fetches details for the associated user, along with authored and liked tweets.
- If user is viewing own profile, they may tap Edit Profile to update their information, banner image, or profile photo.
- User may tap on profile photo to upload to profile photo, outside of the Edit Profile view.

Future updates:
- Additional sign-in methods
- Add images to tweets
- Implement Follower/Following logic 
- Retweets and DMs

Initial inspiration: https://www.youtube.com/watch?v=3pIXMwvJLZs&t=8182s
