# image_viewer
I'm building an example image viewer to learn Flutter.

Focus will be on ***mobile*** first then ***desktop***

## Backlog
- [ ] Re-architect to use BLoC pattern from codelab

- [ ] **Milestone #1**
    - [ ] 1. Add folder to persisted configuration
        * Use `path_provider` to get local storage path
        * Use `shared_preferences` to persist configuration
    - [ ] 2. Load folder selection(s) from persisted configuration on boot
    - [ ] 3. Show all images from all folders in single grid view
    - [ ] 4. Show image view when thumbnail tapped (jpg, gif, png and txt files)
    - [ ] 5. Scroll through images backward or forward from image view

- [ ] **Subfolder feature**
    - [ ] Folder thumbnail is stack of images
    - [ ] Tap folder to view gallery of images in the folder
    - [ ] Switch from folder view to standard gallery view

- [ ] **Sorting feature**
    - [ ] Alphanumeric by default

- [ ] **Tags feature**
    - [ ] Add tags to image
    - [ ] Show tags for image
    - [ ] Persist tag metadata per image
    - [ ] Filter by tags

## Sometime
- [ ] ?
- [ ] Dark mode with moon/sun toggle button icon
- [ ] Automatically find picture folders
- [ ] Ability to browse folders
- [ ] Gallery view (i.e. folders) vs image view (i.e. all images)
- [ ] Image detail view when slide up
- [ ] Grouping options (i.e. by date, by folder, etc.)
- [ ] Image detail view when slide up
- [ ] Save scroll locaiton when changing screen size
- [ ] Linux desktop type window decorations for desktop
- [ ] Load and save images from/to remote server
- [ ] Select multiple images for manipulation operations
- [ ] Support common image manipulation operations
- [ ] Cast to google chrome cast devices

## Completed

- [X] View image full screen when thumbnail tapped
- [X] Navigation rail in wide view and bottom navigation bar in narrow view
- [X] Zoomable thumbnail size
- [X] Image grid view