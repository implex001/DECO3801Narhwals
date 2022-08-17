# Caravaneering

An exercise game

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Current Build Status
[![Flutter](https://github.com/implex001/DECO3801Narhwals/actions/workflows/dart.yml/badge.svg)](https://github.com/implex001/DECO3801Narhwals/actions/workflows/dart.yml)

[Download the nightly main builds](https://github.com/implex001/DECO3801Narhwals/actions/workflows/dart.yml)

## Fit Api Setup
To interface with the platform level components, pigeon is used to create a typesafe method to 
communicate. The command to generate the interface files is:
```shell
flutter pub run pigeon \
  --input pigeon/fit_interface.dart \
  --dart_out lib/model/fit/FitInterface.dart \ 
  --objc_header_out ios/Runner/FitInterface.h \
  --objc_source_out ios/Runner/FitInterface.m \
  --experimental_swift_out ios/Runner/FitInterface.swift \
  --java_out ./android/app/src/main/java/com/digitalnarwhals/caravaneering/fitapi/FitInterface.java \
  --java_package "com.digitalnarwhals.caravaneering.fitapi"
```

## Setting up for Android Development
Ensure when setting up, use API 30 (Android 11) as SDK. Recommend using Android 
Studio as it guides you through the SDK installation
If you are getting weird errors in the gradle files [this](https://stackoverflow.com/questions/56938436/first-flutter-app-error-cannot-resolve-symbol-properties)
may help
