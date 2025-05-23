# Flutter install

## Ubuntu

```
sudo snap install flutter --classic

flutter doctor
```

Android Studio
```
File > Settings > Languages & Frameworks > Android SDK -> SDK Tools 

-> [v] Android SDK Command-line Tools (latest)
-> [v] NDK (Side by side)

[Apply]

Install Flutter plugin
```

```
flutter doctor --android-licenses
```

## Emulators
```
flutter emulators
flutter emulators --launch <name>
flutter devices
```


## Create new application

```
flutter create my_app
cd my_app
flutter run
```

## Other
Clean an run project

```
flutter clean
flutter pub get
flutter run

flutter upgrade
flutter pub cache repair
```