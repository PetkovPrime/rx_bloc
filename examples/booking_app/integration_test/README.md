# E2E INTEGRATION TESTING

## Setup

## Flutter inspector
To debug a layout issue, run the app in debug mode and open the inspector by clicking the Flutter Inspector tab on the DevTools toolbar.

Note: You can still access the Flutter inspector directly from Android Studio/IntelliJ, but you might prefer the more spacious view when running it from DevTools in a browser.

Debugging layout issues visually
The following is a guide to the features available in the inspector’s toolbar. When space is limited, the icon is used as the visual version of the label.

![Select widget mode icon](https://docs.flutter.dev/assets/images/docs/tools/devtools/select-widget-mode-icon.png)***Select widget mode icon Select widget mode***  
Enable this button in order to select a widget on the device to inspect it. For more information, see Inspecting a widget.

Refresh tree icon Refresh tree
Reload the current widget info.
Slow animations icon Slow animations
Run animations 5 times slower to help fine-tune them.
Show guidelines mode icon Show guidelines
Overlay guidelines to assist with fixing layout issues.
Show baselines icon Show baselines
Show baselines, which are used for aligning text. Can be useful for checking if text is aligned.
Highlight repaints icon Highlight repaints
Show borders that change color when elements repaint. Useful for finding unnecessary repaints.
Highlight oversized images icon Highlight oversized images
Highlights images that are using too much memory by inverting colors and flipping them.


## Locator Strategy

## POM

## BDD

## Creating tests

## Running tests

## Naming Conventions

## Cons