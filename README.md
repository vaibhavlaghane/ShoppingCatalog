# ShoppingCatalog

The Project connects to the API endpoint to download the json list of products along with details.
The project supports portrait mode for devices -  iPhone SE onwards.

The list is of product titles is diplayed on the 1st view and the details of the product along with image are shown in the next pane.

The initial viewcontroller shows data in UITableViewController
The next set of views are CollectionViewController with custom layout for various size classes.

ThirdParty library has been integrated for the UIloading indicator effect while scrolling at bottom[ when user reaches at the bottom of the list ]

The project can be opened by double clicking on the file - ShoppingCatalog.xcodeproj
Unit tests have been added - in folder - ShoppingCatalogTests

Project Layout -

-Model group - contains model for product-
-Network group - contains the network related activies -
-Resources group - contains main.storyboard, assets, info.plist
-Utility group - with utility methods and global constants
-Viewcontroller group contains the files for collection view controller, it's cell

ShoppingCatalog-Bridging-Header.h is needed to use thirdparty library compiled in  Objective C

Results achieved per the requirements :

Screen 1:
- First screen should contain a List of all the products returned by the Service call.
- The list should support Lazy Loading. When scrolled to the bottom of the list, start lazy loading next page of products and append it to the list.

Screen 2 (optional):
- Second screen should display details of the product.
Ability to swipe to view next/previous item ( Eg: Gmail App)

