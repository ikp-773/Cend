# Development Phase


## Statement of Goals

Cend is intended to be a cross-platform application that facilitates file transfer without the use of mobile data. It also provides a chat room to people nearby without any charges. 

As many people are stuck home due to pandemic this could help people interact with each other in a different way than conventional.

Recently the Indian Government has banned over 50  Chinese applications from India. These also included Xender and ShareIt. These were the most intensively used application for file sharing in India for Android User. 

So currently the market requires a good file-sharing application thus I came across with the idea of Cend.








 
## Functional Description

Basic functionalities (current version) of Cend only include the transfer of all kind of files over a wireless network at a limited speed for Android users.

The workflow is quite similar to that of Android Nearby Connections Library in Flutter.

The connections won’t break easily if location services are turned ON on both devices.

The files transfer happens over wifi, BlueTooth or hotspot after analysing the transfer speed. 

The application uses several flutter packages. Some of the important ones that work as a backend of the app currently are: 
- nearby_connections 
 	- https://github.com/mannprerak2/nearby_connections
- provider
	- https://github.com/rrousselGit/provider
- shared_preferences
	- https://github.com/flutter/plugins
- file_picker
	- https://github.com/miguelpruivo/plugins_flutter_file_picker

 
## Milestones

Now the application is only designed for android. Need to make it cross-platform for iOS users.

Application is not yet compactable for messaging without any charges. Need to add functionality for messaging.

Need to add a custom light or dark theme also add a side drawer for accessing setting and customer support.

Bottom Navigation Bar would be a handy tool once the  messaging option is integrated.

Alpha application expected to be completed in September.
