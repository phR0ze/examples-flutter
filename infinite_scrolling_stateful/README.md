# infinite_scrolling_stateful
Original work from https://blog.logrocket.com/implement-infinite-scroll-pagination-flutter/

## Notes:
The `setState` pattern tightly couples out business logic to the UI as the `setState` function is only available in the `State` class.

As such Flutter's built in state management is only useful for simple cases where there is none to small amounts of business logic.