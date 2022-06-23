# ComeOnAssignment
As requested this repository contains a solutions for Come On Group recruitment assignment

# Details
This app is built with SwiftUI + Combine framework, it doesn't use any 3rd party dependency.

Architecture used is (a bit crude) version of MVVM + Coordinator pattern. 
For business logic we are using usecases (use case to be exact :))

Communication with website is done via native WKWebView components, basically userContentController

That's about it. If there are any additional questions feel free to write to me.

# How to run
Make sure to run the website first with ***npm start*** command

To run the app just clone this repository, open ***.xcodeproj*** file, choose simulator/device of your liking and hit ***CMD+R*** or choose proper options from Xcode

To run tests hit ***CMD+U*** or choose proper option from Xcode. You don't need to run the website to run tests, they are relying on mock connection and stubs.
