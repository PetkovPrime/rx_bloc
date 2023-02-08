# E2E INTEGRATION TESTING

## Findings
1. Public classes in Flutter (search_page_keys.dart).
2. Handling list of elements?
3. Will adding Keys (locators) to UI elements cause issues in terms of that piece of code being
   reused in other parts of the UI?
   Example: Sort button from search page being reused in some other page.
4. Import of classes (import 'package:integration_test/keys/search_page_keys.dart';).
5. What is the difference between defining keys in constructor of the class and having a
   separate key.dart containing keys for specific page that help locate elements.
6. kotlin-android plugin failing when executing patrol tests.
7. Finding multiple elements with keyBtnSort when put in focus_button.dart.
8. When using 'key: Key('locHotelItem${item.id}')', how do we know what the id is
   when locating element?
9. Dart naming conventions

## Introduction
Unit tests and widget tests are handy for testing individual classes, functions, or widgets. However, they generally don’t test how individual pieces work together as a whole, or capture the performance of an application running on a real device. These tasks are performed with integration tests.

Integration tests are written using the **integration_test** package, provided by the SDK.

##Tech Stack
* Dart
* Flutter
* Antroid Studio
* Xcode

## Setup
* Check the official [Windows](https://docs.flutter.dev/get-started/install/windows) installation guide.

* Check the official [MacOS](https://docs.flutter.dev/get-started/install/macos) installation guide.

* Check the official [Set up an editor](https://docs.flutter.dev/get-started/editor) guide.

## Project Structure

## Naming Conventions
Finders starts with prefix **loc** followed by **Type** and **Name**:

| Finder type      | Predix      | Example                          |
| ---------------- | ----------- |--------------------------------- |
| TextBox          | txt         | locTxtEmail, locTxtPassword      | 
| Button           | btn         | locBtnRegister, locBtnLogin      |
| CheckBox         | cb          | locCbGender, locCbSalaryRange    |
| DropDown         | dd          | locDdCountry, locDdYear          |
| Hyperlink        | lnk         | locLnkFQA                        |
| Image            | img         | locImgLogo                       |
| Label            | lbl         | locLblUserName                   |
| ListBox          | lb          | locLbPolicyCodes                 |
| RadioButton      | rbtn        | locRbtnIsMandatory               |
| Table            | tbl         | locTblBooks, locTblProducts.     |
| Header           | hrd         | locHdrPrint, locHdrUser          |



### Tests

## Locator Strategy
### Flutter inspector
To debug a layout issue, run the app in debug mode and open the inspector by clicking the Flutter
Inspector tab on the DevTools toolbar.

**Note:**You can still access the Flutter inspector directly from Android Studio/IntelliJ,
but you might prefer the more spacious view when running it from DevTools in a browser.

**Debugging layout issues visually**  
The following is a guide to the features available in the inspector’s toolbar. When space is limited,
the icon is used as the visual version of the label.

![Select widget mode icon](https://docs.flutter.dev/assets/images/docs/tools/devtools/select-widget-mode-icon.png)***Select widget mode***  
Enable this button in order to select a widget on the device to inspect it.
For more information, see Inspecting a widget.

![Refresh tree icon](https://docs.flutter.dev/assets/images/docs/tools/devtools/refresh-tree-icon.png)
***Refresh tree***  
Reload the current widget info.

![Slow animations](https://docs.flutter.dev/assets/images/docs/tools/devtools/slow-animations-icon.png) ***Slow animations***  
Run animations 5 times slower to help fine-tune them.

![Show guidelines](https://docs.flutter.dev/assets/images/docs/tools/devtools/debug-paint-mode-icon.png) ***Show guidelines***  
Overlay guidelines to assist with fixing layout issues.

![Show baselines](https://docs.flutter.dev/assets/images/docs/tools/devtools/paint-baselines-icon.png) ***Show baselines***  
Show baselines, which are used for aligning text. Can be useful for checking if text is aligned.

![Highlight repaints](https://docs.flutter.dev/assets/images/docs/tools/devtools/repaint-rainbow-icon.png) ***Highlight repaints***  
Show borders that change color when elements repaint. Useful for finding unnecessary repaints.

![Highlight oversized images](https://docs.flutter.dev/assets/images/docs/tools/devtools/invert_oversized_images_icon.png) ***Highlight oversized images***  
Highlights images that are using too much memory by inverting colors and flipping them.

For more info you can check the official [Flutter Inspector](https://docs.flutter.dev/development/tools/devtools/inspector#:~:text=all%20Flutter%20applications.-,What%20is%20it%3F,%2C%20rows%2C%20and%20columns) documentation.  
Check _Flutter Inspector_ usage here [DartConf 2018](https://www.youtube.com/watch?v=JIcmJNT9DNI&ab_channel=GoogleDevelopers).
### Handling Keys

## Creating tests

## Running tests
**Run tests using IntelliJ or VSCode**  
The Flutter plugins for IntelliJ and VSCode support running tests. This is often the best option while writing tests because it provides the fastest feedback loop as well as the ability to set breakpoints.

**IntelliJ**
1. Open the app_test.dart file.
2. Select the Run menu.
3. Click the Run 'tests in app_test.dart' option.
4. Alternatively, use the appropriate keyboard shortcut for your platform.

**VSCode**
1. Open the app_test.dart file.
2. Select the Run menu.
3. Click the Start Debugging option.
4. Alternatively, use the appropriate keyboard shortcut for your platform.

**Run tests in a terminal**  
You can also use a terminal to run the tests by executing the following command from the root of the project:  
`flutter test test/app_test.dart`

For more options regarding unit tests, you can execute this command:    
`flutter test --help`