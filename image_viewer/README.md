# image_viewer
Working on a simple image viewer in Flutter

## Backlog
* Sometime
  * [ ] Add slide up panel https://pub.dev/packages/sliding_up_panel for image info
  * [ ] Setup Android storage permissions better
  * [ ] Improve pinch to zoom sensativity
  * [ ] Persistent thumbnail cache
  * [ ] Pre-cache prev and next images for performance

* Next up
  * [ ] Allow for shrinking thumbnails down smaller at least to 5 wide
  * [ ] Flow light/dark mode toggle throughout image pager (invert text color)
  * [ ] Text view is cutting off last character of longest line on right margin
  * [ ] Pinch to zoom only seems to work about half the time

* Pre-release 0.0.2
  * [X] Using SafeArea to avoid hiding content behind controls on bottom of screen
  * [X] Show placeholder image if not image or text for easy image viewer
  * [X] Increased thumbnail generation speed by caching thumbnails

* Pre-release 0.0.1 - delivered
  * [X] Write TextImageProvider
  * [X] Display all folders first and sort folders and files alphabetically
  * [X] Use easy_image_viewer for swipe, pinch to zoom and pan
  * [X] Navigate to prev and next from content page
  * [X] Add top level folder selection
  * [X] Add a button to switch between light and dark mode
  * [X] Responsive layout for mobile and desktop
  * [X] Dismiss previous snackbar when a new one is triggered
  * [X] Adding global snackbar for comms to the user
  * [X] Add GetIt for global service access

<!-- 
vim: ts=2:sw=2:sts=2
-->
