# 📤Cend📲
[![License: MIT](https://img.shields.io/badge/license-MIT-red.svg)](https://opensource.org/licenses/MIT) ![GitHub top language](https://img.shields.io/github/languages/top/ikp-773/custom_pin_entry_field)  ![Platform Support](https://img.shields.io/badge/platform-android-green) ![Forks](https://img.shields.io/github/forks/ikp-773/Cend?style=social)

Cend is a file transfer application for android through which file can be shared to android devices nearby without network.
<img src="screenshots/3.png?raw=true" width=300 >
## Usage
<div>
<img src="screenshots/1.png?raw=true" width=300 >
<img label="Reciver" src="screenshots/4.png?raw=true" width=300 > 
<img src="screenshots/2.png?raw=true" width=300 >
<img src="screenshots/sender start.gif?raw=true" width=300 >
<img src="screenshots/sender end.gif?raw=true" width=300 >
<img src="screenshots/reciver.gif?raw=true" width=300 >

</div>

## Functional Description

Basic functionalities (current version) of Cend only include the transfer of all kind of files over a wireless network at a limited speed for Android users.

The workflow is quite similar to that of Android Nearby Connections Library in Flutter.

The connections won’t break easily if location services are turned ON on both devices.

The files transfer happens over wifi, BlueTooth or hotspot after analysing the transfer speed.

######Permissions Required
To discover nearby users and share files more efficiently, Cend needs some permissions as follows:
- android.permission.ACCESS_COARSE_LOCATION
- android.permission.ACCESS_FINE_LOCATION
- android.permission.WRITE_EXTERNAL_STORAGE
- android.permission.READ_EXTERNAL_STORAGE
- android.permission.WRITE_SETTINGS 

## Statement of Goals

Cend is intended to be a cross-platform application that facilitates file transfer without the use of mobile data. It also provides a chat room to people nearby without any charges. 

As many people are stuck home due to pandemic this could help people interact with each other in a different way than conventional.

Recently the Indian Government has banned over 50  Chinese applications from India. These also included Xender and ShareIt. These were the most intensively used application for file sharing in India for Android User. 

So currently the market requires a good file-sharing application thus I came across with the idea of Cend.

 
## Milestones

Now the application is only designed for android. Need to make it cross-platform for iOS users.

Application is not yet compactable for messaging without any charges. Need to add functionality for messaging.

Need to add a custom light or dark theme also add a side drawer for accessing setting and customer support.

Bottom Navigation Bar would be a handy tool once the  messaging option is integrated.

Alpha application expected to be completed in September.

###Packages Used

The application uses several flutter packages. Some of the important ones that work as a backend of the app currently are: 
- nearby_connections 
 	- https://github.com/mannprerak2/nearby_connections
- provider
	- https://github.com/rrousselGit/provider
- shared_preferences
	- https://github.com/flutter/plugins
- file_picker
	- https://github.com/miguelpruivo/plugins_flutter_file_picker
