# My Docs

## Run on a web server

- type `flutter run -d web-server`.  Then you can open the url where `lib/main.dart` is served (it is shown on console), from the browser of your choice (e.g Firefox).
- Then type `r` or `R` to hot restart.

## 5.22 GoRouter Redirects

- Note that if the URL is changed manually, the whole UI is restarted which means that any states not persisted are lost.

## 5.23 Fix checkout flows bug

- See tutorial notes but basically the page keys are not handled as you would expect.

## 6.13 Test AccountScreenController - 1

- `AsyncData<void>` is the same as `AsyncValue<void>.data`.
- `AsyncLoading<void>` is the same as `AsyncValue<void>.loading`.
- When testing `AccountScreenController`, you can use `AsyncData<void>` or `AsyncLoading<void>` to test the `AccountScreenController`'s `_onAccountChanged` method.
- When testing, use `controller.debugState` instead of `controller.state`.

## 6.14 Test AccountScreenController - 2

- Mocks are explained here in more detail. `Mocktail` is used instead of `Mockito` because it seems to be more flexible.

## 6.15 Test AccountScreenController - 3

- `ISA` method checks to that the type is correct and `hasError` checks that an error is thrown.  Both methods are showing the same thing so only one is really necessary.

## 6.17 Test EmailSignInController - 2

- Also refactored by creating a `mocks.dart` file.
