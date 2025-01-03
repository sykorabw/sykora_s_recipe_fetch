# Sykora's Recipe Fetch App

## Steps to Run the App:
- Download project from github
- Run locally in XCode
- Once in the application, pulling down to refresh will clear the SwiftData persistence and re-fetch the data (including the photos).
- Tapping on a row will reveal the source URL. Tapping anywhere in that card will bring you back.
- Tapping on the blue link at the bottom will take you to an external site to play the video.

## Focus Areas:
- Accessibility - I ran the app through a voiceover checker and tried to make reasonable choices to help out voiceover users.  Granted, the flipping cards isn't the best choice for accessibility concerns.
- Reduce image hitching while scrolling - Loading the images and caching them in this way reduced image hitching that can occur with AsyncImage.
- Strict concurrency checking - Although not something I work with daily, I wanted to demonstrate that I am able to work with this mode. My team has been investigating how to migrate to strict concurrency checking.
- Dark mode support / testing - Tested and supported dark mode in the application.
- iOS and iPad support / supporting size changes for larger screens - Larger images are loaded for iPad devices vs iOS devices.

## Time Spent: ~13 hours of development
- A large portion of my time was spent implementing the interactions between the main screen, the actors, the APIs, and the Persistence models
- After that, another chunk was spent on streamlining and displaying images.
- Finally, wrapping up the project, I made sure to check accessibility tools and multiple device formats.

## Trade-offs and Decisions:
- AsyncImage vs more manual API and Image (performance)
- Spent more time with something I'm less comfortable with (strict concurrency) to show I'm a quick study.
- Normally I would like to isolate the API and ViewModel tests a bit more with mocks and mock data.  I don't like having unit tests testing with real URLs.  This would have been my next step to address.
- I also would have implemented a Endpoint class to remove the force in the Endpoints enum.
- What did I unit test? Answer: Backend code and ViewModels. I agree with the perspective that Views and Models in MVVM should be simple and mostly void of business logic. If so, they are mostly pointless to test deeply. That being said, see my next point.
- Something I've done in the past is pull in the nalexn/ViewInspector dependency in so that I can unit test some basic views. This usually just helps me eliminate the need for UI testing every piece and makes many more things unit testable. The bonus, to me, is the unit tests run much faster.
- I used basic colors, fonts, and stylings that were readily available to me instead of spending lots of time customizing those.

## Weakest Part of the Project:
- The stylings are a bit basic.  The rotating rows are not necessarily the best for accessibility.  
- I would have liked to do more with testing, like isolating unit tests with mock data.
- View's could be a bit more refined.

## Additional Information
- Thank you so much for the chance to demonstrate my ability and hopefully hear back from you.
