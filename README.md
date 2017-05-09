# FoHo

----

Recipe application built off of Yummly's API

----

## By FohoDuo - Scott Williams and Brittney Ryn

### Application features

#### - Easy to use UI
  - Includes a tab bar for quick navigation between app features

#### - Home Menu
  - Loads sample search results suggestions for the user

#### - Recipe Search
  - Allows users to search from Yummly's database containing over 1,000,000 recipes
  - Allow users to specify a maximun completion recipe time
  - Allows user to filter results to narrow down a search by clicking the options bar button. Included filters:
    - Dietary options
    - Food allergy options
    - Type of course options
    - Type of cuisine options
  - Users may select a found recipe to view more detailed inforation which includes:
    - Recipe name
    - Total time the recipe takes to complete
    - List of ingredients
    - Number of servings
    - A link which navigates to a webpage containing the recipe's steps

#### - Shopping Cart
  - Users may add ingredients found from searching by clicking the button next to the ingredient
  - Users may also manually enter items on the shopping cart page by clicking Add bar button
  - Users can tap an item on the list to "check it off" (*These persist if you change views but are lost on app reset*)
  - Users can delete items by swiping right on a cell and clicking the delete button

#### - Favorites List
  - Users can click the heart (favorite) button after finding a recipe and have it become saved (an animation will occur and the button will become red)
  - Users can remove the favorite by clicking the heart a second time (it will turn grey)
  - In the favorites view, users can see a list of all favorited items
  - Users can also remove favorites from this page

#### - Options
  - Allow users to change their search settings
  - Allow users to delete saved data including favorites and the shopping cart list
  - Allow users to restore filter settings to their default state and modify them
  

#### - Social Media
  - Allows users to post recipes discovered from searches onto either their Facebook or Twitter feed


### Other Information
  - Developed in Xcode Version: 8.3.2
  - Written in Swift 3
  - Uses Cocoapods including:
    - AlamoFire
    - FaveButton
    - SideMenu
    - RAMAnimatedTabBarController
