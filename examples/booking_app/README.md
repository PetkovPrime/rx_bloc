# Booking App

## Getting started

Before you start working on your app, make sure you familiarize yourself with the structure of the generated project and the essentials that are included with it.

*Note:* The app contains features that request data from API endpoints hosted on a local server. For the app to function properly, make sure the local server is up and running. For more info, check out the [server topic](#server).

## Project structure

| Path | Contains |
| ------------ | ------------ |
| `lib/base/` | Common code used on more than one **feature** in the project. |
| `lib/base/app/` | The root of the application and Environment configuration. |
| `lib/base/common_blocs/` | Global [BLoCs][rx_bloc_info_lnk]|
| `lib/base/common_ui_components/` | Reusable widgets (buttons, controls etc) |
| `lib/base/common_use_cases/` | Global UseCases |
| `lib/base/data_sources/` | All data sources are placed here. |
| `lib/base/data_sources/domain/` | Data sources,  relating to a specific domain |
| `lib/base/data_sources/domain/counter/` | Data sources,  relating to the counter domain |
| `lib/base/data_sources/local/` | Local data sources, such as shared preferences, secured storage etc. |
| `lib/base/data_sources/remote/` | External data sources like APIs. Here is placed all [retrofit][retrofit_lnk] code. |
| `lib/base/data_sources/remote/interceptors/` | Custom interceptors that can monitor, rewrite, and retry calls. |
| `lib/base/di/` | Global dependencies, available in the whole app|
| `lib/base/extensions/` | Global [extension methods][extension_methods_lnk] |
| `lib/base/models/` | Data models used in the project |
| `lib/base/repositories/` | Repositories used to fetch and persist models.
| `lib/base/routers/` | All [routers][autoroute_usage_lnk] are placed here. The main [router][autoroute_usage_lnk] of the app is `lib/base/routers/router.dart`. |
| `lib/base/routers/guards/` | The routers' [guards][autoroute_usage_lnk] of the app are placed here. |
| `lib/base/theme/` | The custom theme of the app |
| `lib/base/utils/` | Global utils |
| `lib/feature_X/` | Feature related classes |
| `lib/feature_X/blocs` | Feature related [BLoCs][rx_bloc_info_lnk] |
| `lib/feature_X/di` | Feature related dependencies |
| `lib/feature_X/use_cases/` | Feature related UseCases |
| `lib/feature_X/ui_components/` | Feature related custom widgets |
| `lib/feature_X/views/` | Feature related pages and forms |
| `lib/main.dart` | The main file of the app. If there are more that one main file, each of them is related to separate flavor of the app. |

## Feature structure

Each feature represents a separate flow in the app. They can be composed of one or more pages (screens) placed inside the features `views` directory. **Every page (screen) should be implemented as a Stateless Widget.**

The logic of each page should be placed into its own [BLoC][rx_bloc_lnk]. This is desired especially if the page has to be a **Stateful Widget**. The BLoC is placed inside the `blocs` directory. In order for the BLoC to be more readable, its implementation details can be offloaded to its own extensions file ( `[bloc_name]_extensions.dart`, placed inside the same directory) or one or more usecases.

## Architecture
<img src="https://raw.githubusercontent.com/Prime-Holding/rx_bloc/develop/packages/rx_bloc_cli/mason_templates/bricks/rx_bloc_base/__brick__/docs/app_architecture.jpg" alt="Rx Bloc Architecture"></img>

<div id="navigation"/>

### Navigation

Navigation throughout the app is handled by [Auto Route][autoroute_lnk].

After describing your pages inside the `lib/base/routers/router.dart` file and running the shell script `bin/build_runner_build.sh`(or `bin/build_runner_watch.sh`), you can access the generated routes by using the `context.navigator` widget.

<div id="locatization"/>

### App localization

Your app supports [localization][localization_lnk] out of the box.

You define localizations by adding a translation file in the `lib/l10n/arb/app_[language_code].arb` directory. The `language_code` represents the code of the language you want to support (`en`, `zh`,`de`, ...). Inside that file, in JSON format, you define key-value pairs for your strings. **Make sure that all your translation files contain the same keys!**

Upon rebuild, your translations are auto-generated inside `.dart_tool/flutter_gen/gen_l10n`. In order to use them, you need to import the `l10n.dart` file from `lib/l10n/l10n.dart` and then access the translations from your BuildContext via `context.l10n.someTranslationKey`.

<div id="analytics"/>

### Analytics

[Firebase analytics][firebase_analytics_lnk] track how your app is used. Analytics are available for iOS, Android and Web and support flavors.

Before you start using analytics, you need to add platform specific configurations:
1. The `iOS` configuration files can be found at `ios/environments/[flavor]]/firebase/GoogleService-Info.plist`
2. For `Android` the configuration files are located at `android/app/src/[flavor]/google-services.json`
3. All `Web` analytics configurations can be found inside `lib/base/app/config/firebase_web_config.js`

Flutter booking application.

## Purpose of the project 
The main purpose of the project is to showcase the possible solutions when it comes to using Backend-as-a-Service(BaaS) products.
Installation 
Checkout and download these two projects: 
 - https://github.com/Prime-Holding/rx_bloc/tree/master/examples/booking_app
 - https://github.com/Prime-Holding/firebase-cloud-functions

To setup the project you have to first to run: [flutter packages pub run build_runner build --delete-conflicting-outputs]
Then edit configurations your depending what kind of data source you want to use. 
1. main.dart for entrypoint && [local] flavor argument for local database
2. main_firebase.dart for entrypoint && [firebase] flavor argument for firebase
3. main_firebase_algolia.dart for entrypoint && [firebase_algolia] flavor argument for firebase + algolia

## Most popular solutions on the market 
 - Firebase 
 - Elasticsearch
 - Algolia
 - Amplify

## The implementation
Firebase is the most feature rich service on the market by far, that’s why we’ve decided to use their service as our primary data storage solution. Firebase has also one of the best geolocation services on the market which is very beneficial for mobile applications.

During the process of development we’ve stumbled on some serious limitations from their side including: 
  - Can't apply more than one comparison operator (<, <=, >, >=) on more than one field.
  - There's no LIKE operator
  - Paginated result does not contain total results counter
  - There's no count query
  - whereIn operator value is limited to array of 10 elements

Because of these limitations we decided to use additional service in order to bypass the already discovered flaws. 

Elasticsearch and Algolia provide very similar services to Firebase. Because of the pricing policy of Elasticsearch we decided to use Algolia on top of our Firebase solution.

Algolia also comes with its pros and cons. 
The main cons are:
 - Limited or almost non-existent community 
 - Does not have flutter implementation(you have to use it inside firebase cloud functions)
 - Sorting is still unclear and nonfunctional 
 
Due to the different advantages and disadvantages of each service we’ve come up with a decision 
to make the app work with both Firebase and Firebase Cloud Functions + Algolia in order for any client to be aware of what both services can and cannot provide.

## The result 
The final app works with three types of data sources: 
 - Local data source - the data is generated internally using the local memory. 
 - Firebase data source - the data is migrated into the Firestore Cloud, paginated according to the documentation. The user could face different errors while testing out the app - applying 2 filters, using the search bar & etc. All that because of the above described Firebase API limitations.
 - Firebase + Algolia data source - the data is migrated into the Firestore Cloud and the Algolia Storage API using the Firebase Cloud Functions. Using the cloud functions we were able to bypass some of the Firebase’s limitations. Sorting still does now work. I’ve created an issue ticket in their community board but due to lack of community members there is still no progress on this.

Take a look at our diagram called for further explanation of our data source services.
<img src="./doc/assets/diagram.jpg" alt="Booking App Diagram"></img>
