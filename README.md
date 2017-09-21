# ImageBrowser
Image Browser Test using Flickr API

This Example uses the the Flickr API to retrieve a public feed and displays the list of images in a collection view.  The code aims to stick to SOLID princibles by ensuring that dependencies on the Flickr API are loosely coupled via inheritance and class extensions, thus using a different provider can easily be achieved by implementing a subclass of ImageViewProvider with your specific image loader and providing and ImageViewModel extension method to map the image and title.

The program inlcudes Unit tests build with test driven development up until the UI integration at which point some code does not have tests, but all the core functionality is tested.

One issue remains, but I think it is really to do with the quality of the flickr feed or the inadiquacy of iOS's json parser - essentially sometimes it can't read the feed due to issues parsing the json related to escape characters.  Either this is because the Flickr feed has junk in it or because iOS is not robust or because of unsupported character sets and how the text is encoded. I didn't have time to find out what was going on or how to resolve this, but I can say that it seems to be a common issue with Flickr and others are also running into the same issue - https://stackoverflow.com/questions/38601572/flickr-feeds-api-parsing-issues
