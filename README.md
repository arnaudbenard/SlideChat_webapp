SlideChat web app
=================

# Context

[Box](https://www.box.com/) organized a hackathon in mid-august 2012 and we wanted to be part of it. The theme was productivity. We build a great solution to enable people to discuss documents while chatting to each other face to face.

The project didn't get any prize but we had fun building it. 

The project has two main components, a [web app](https://github.com/arnaudbenard/SlideChat_webapp) and an [iPad app](https://github.com/FredericJacobs/SlideChat_iPad). Both allow to browse box folders while video-chatting.

Thanks again to Box for hosting this great hackathon.

# APIs 

We are using two APIs, so you should get an API key for those : 

- [The Awesome OpenTok](http://www.tokbox.com/opentok/api/documentation)
- [The Box API](http://developers.box.com/)

The project will not build without those anyway.

This app is a great example of how OpenTok chat streams can be resized dynamically depending on the amount of people in the chat room. This app supports up to 5 people in a discussion.

You can find a working version here: [Demo on Heroku](http://gentle-wildwood-8274.herokuapp.com/)

# Front-end 

The front-end has been build with [1140px CSS grid](http://cssgrid.net). We've used [Modern Pictograms](http://www.fontsquirrel.com/fonts/modern-pictograms) for the icons.

# Building it

Fill the API keys, create box folders and put files in it, share them on Box and fill the ids in the box_helper.rb (in get_folder_data). The app is built with MongoDB (mongoid) and Rails. You should have mongodb installed on your computer.
You're now ready to have fun !

# Contributors 

- [Arnaud Bénard](https://twitter.com/arnaudbenard) 
- [Frederic Jacobs](http://twitter.com/frederic.jacobs)

# License 
SlideChat is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

SlideChat Source Code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the [GNU General Public License](http://www.gnu.org/licenses/) for more details.

Only Apple's Keynote Logo and Facetime lens are copyrighted materials owned by Apple Inc. 