# My Docs

## Run on a web server

- type `flutter run -d web-server`.  Then you can open the url where `lib/main.dart` is served (it is shown on console), from the browser of your choice (e.g Firefox).
- Then type `r` or `R` to hot restart.

## 5.22 GoRouter Redirects

- Note that if the URL is changed manually, the whole UI is restarted which means that any states not persisted are lost.

## 5.23 Fix checkout flows bug

- See tutorial notes but basically the page keys are not handled as you would expect.
