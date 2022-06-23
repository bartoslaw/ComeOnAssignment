# ComeOnAssignment
As requested this repository contains a solution for Come On Group recruitment assignment

# Details
This app is built with SwiftUI + Combine frameworks, it doesn't use any 3rd party dependency.

Architecture used is (a bit crude) version of MVVM + Coordinator pattern. 
For business logic we are using usecases (use case to be exact :))

Communication with website is done via native WKWebView api, basically userContentController

That's about it. If there are any additional questions feel free to ask.

# How to run
Make sure to run the website first with ***npm start*** command

To run the app just clone this repository, open ***.xcodeproj*** file, choose simulator/device (if you want to use your device, please make sure that you are on the same network and use your local ip instead of ***localhost***) of your liking and hit ***CMD+R*** or choose proper options from Xcode

To run tests hit ***CMD+U*** or choose proper option from Xcode. You don't need to run the website to run tests, they are relying on mock connection and stubs.
