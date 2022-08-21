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
[![Android](https://github.com/implex001/DECO3801Narhwals/actions/workflows/dart.yml/badge.svg)](https://github.com/implex001/DECO3801Narhwals/actions/workflows/dart.yml)
[![iOS](https://github.com/implex001/DECO3801Narhwals/actions/workflows/ci_ios.yml/badge.svg)](https://github.com/implex001/DECO3801Narhwals/actions/workflows/ci_ios.yml)

[Download the nightly main builds](https://github.com/implex001/DECO3801Narhwals/actions/workflows/dart.yml)

## Setting up for Android Development
Ensure when setting up, use API 30 (Android 11) as SDK. Recommend using Android 
Studio as it guides you through the SDK installation
If you are getting weird errors in the gradle files [this](https://stackoverflow.com/questions/56938436/first-flutter-app-error-cannot-resolve-symbol-properties)
may help

For Google Fit API access, you will need to sign your app using the keystore and credentials
that have been authorised. Fortunately the build script should handle this for us as long as you
provide these two files:
- <repo-root>/android/develop.jks
- <repo-root>/android/key.properties
These should never be checked into the repo and be always kept secret