# RazManager

RazManager is a Race Management System (RMS) for slot cars.

It's open-source, but you should typically not download the source code itself from this repository.


## Installation

If you want to interact with RazManager, you'll need a RazManager client. You would use that client as race organiser, driver, team or anyone else interested in a slot car event that is taking place (or has taken place) using the RazManager server.

Currently the client isn't available from an app store, i.e. from the Microsoft Store, from Apple's app store, from Google play or as a Linux snap.
Instead, download a version for your operating system from the [releases page](https://github.com/RazManager/RazManager/releases) (link to the right), expand the assets dropdown on the the relase you've choosen, extract the compressed file, and start the excecutable file.


## Hardware and software requirements

A computer/device capable of running
- Windows 10 or 11
- Linux. A Raspberry Pi will work, but it needs at least 2GB RAM.
- macOS (at least 10.14)
- iOS
- Android.

The RazManager client is written in Flutter, so for details about supported OS versions, [please read the Flutter supported platforms documentation](https://docs.flutter.dev/reference/supported-platforms).



### Windows

After extracting the .zip file, simply start razmanager.exe. You'll get a warning that you're trying to run a file from an untrusted source.
Click on "more information" (or similar), and accept to run it anyway.


### Linux

RazManager client versions for Linux, both amd64 (Intel) and arm64 (e.g. Raspberry Pi), are availeble from [Canonical's Snapcraft store](https://snapcraft.io/razmanager). The versions are in the beta channel, and they will update your device automatically. But once RazManager is out of beta, you will need to change to the stable channel.


### macOS

After extracting the .zip file (it if doesn't happen automatically), simply start the RazManager executable. You'll get a warning that you're trying to run a file from an untrusted source. It's a bit complicated to get around this in macOS, but by clicking the question mark in the warning popup and very carefully following the instructions, you should be able to start it.


### iOS

(Will be avilable later)


### Android

You can download an .apk file from the [releases page](https://github.com/RazManager/RazManager/releases) and install the RazManager Android app that way. Search you internet for how-to install an apk on your own device, it may vary a bit between devices of versions of Android.


## Licensing

RazManager uses a MIT license, essentially meaning that you use the source code anyway you want.

The source code has a dependency upon Syncfusion Flutter Charts, which [requries a specific license](https://pub.dev/packages/syncfusion_flutter_charts/license). If you use source code parts that require a Syncfusion library, you're required to [get a Syncfusion license yourself](https://www.syncfusion.com/sales/communitylicense).