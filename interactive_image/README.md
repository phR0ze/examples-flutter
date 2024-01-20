# interactive_image
Researching the interactiveviewer class
https://api.flutter.dev/flutter/widgets/InteractiveViewer-class.html

## Backlog
- [ ] Use dark and light themes for background
- [ ] Support double tap to zoom allow two zooms before resetting

* Editing features
  - [ ] Rotate images

* Basic features
  - [ ] Dismissible AND PageView both interfer with InteractiveViewer's Zooming
  - [X] Properly dispose of controllers
  - [X] Support loading custom image providers
  - [X] Supports mouse for page swiping on Linux
  - [X] Block page swiping when the image is scaled 
  - [X] Block page dissmissing when the image is scaled 
  - [X] Use Dissmissible to make the pager dimissible
  - [X] Add a close button to the image pager
  - [X] Use PageView to make the image view page swipeable
  - [X] Hide and restore system ui controls when viewing an image full screen
  - [X] Use the InteractiveViewer class to pan and zoom an image