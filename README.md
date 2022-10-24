# pinpin

1037拼拼

1037pinpin

## Getting Started

This project is a starting point for a Flutter application.

使用GetX框架进行状态管理

Use GetX for UI state management

### Build APK or IPA

> Optional 
> 
> `flutter run --profile --cache-sksl [--purge-persistent-cache]`
> 
> tap M
> 
> Add `--bundle-sksl-path flutter_01.sksl.json` subcommand

`flutter build ios`

`flutter build apk --obfuscate --split-debug-info=build/split-debug-info/ --split-per-abi`

### Build WEB

`flutter build apk --obfuscate --split-debug-info=build/split-debug-info/ --split-per-abi`

### Generate Json Model

`flutter packages pub run build_runner build --delete-conflicting-outputs`