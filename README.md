# Marvel Characters tvOS app 

This is a simple implementation of a tvOS application that leverages the Marvel API to display a list of all Marvel characters. When clicking on a character's profile, a user can see all of the comics that that character appeared in.

![Simulator Screen Recording - Apple TV 4K (3rd generation) - 2024-03-03 at 17 06 21](https://github.com/colson0804/MarvelCharacters/assets/5607871/dd30c464-76c7-456e-9189-90c1e4e79c41)

## Future improvements 

There's a number of improvements that can be made for this to be a production level app, including but not limited to 
* Storing public and private API keys on a personal server. Leverage an endpoint on this server to call the Marvel API methods
* Smarter pagination - The "Show More" button is clunky. The user should be able to scroll seamlessly without needing to request more results
* Full character details and image on the Comics screen. There's a lot of valuable real estate that can be used to present more information
* Full comic details when tapping on an issue number. Some comic titles may be cut off
* When scrolling through character list, profile images are cut off att the top
* Search functionality and sorting characters by popularity
