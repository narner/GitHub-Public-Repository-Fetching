# GitHub-Public-Repository-Fetching



**Prompt**: https://www.notion.so/iOS-Take-Home-Challenge-a31f897893df4099bb2e00ea4bf225b5

**Design Guide**: https://www.figma.com/file/8koh2PrHJi813R2wERYxUn/iOS-Take-Home-Challenge?node-id=0%3A1



![Demo](/Demo.gif)



**Design Decisions**

I chose to use a modified version of a `UICollectionVIewFlowLayout` from this [Apple Example Project](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts/customizing_collection_view_layouts), as I felt it would produce the best user interface for displaying a scrolling list of GitHub repositories per the design specification.

The thing that I'm most proud of having learned how to do was figuring out how to add a `UIActivityIndicator` in the footer of a `UICollectionView`, and to display it when the user has scrolled to the bottom of the CollectionView. The default CollectionView has an activity indicator that is displayed at the top of the view if the user pulls to refresh it, so I had to implement a custom footer with an embedded activity indicator at the bottom of the CollectionView when a user scrolled to the bottom. 



**Problems/Notes on API Limitations**

When fetching the list of public repositories from the GitHub API, the API does not provide any way to determine when a repository was last modified. 

It may be possible to traverse the list of files that are in a repository, find when *they* were last modified, and then use that information to determine when the repository was last modified, but that seemed somewhat out of scope for the intended use-case. 



**Preparing for Production**

There are a few edge cases / final polish things I would absolutely want to do in the event that this code was being prepared for production: 

*Authentication*

If this was an application that was being released for production, I would want to make sure that there was an additional step of performing authentication with the GitHub API before fetching the lists of repositories, so that the app wouldn't run into the issue of [rate limiting](https://docs.github.com/en/free-pro-team@latest/rest/reference/rate-limit).

*Network Connectivity*

The app currently doesn't handle any scenario in the event of a loss of network connectivity - in there scenario that there was a network loss, I would want to make sure that the user was informed appropriately. Additionally, if there is slow or poor network connectivity, and the list of repositories was not able to be fetched in a certain amount of time, I would want the app to inform the user that there was a timeout error, and to inform them to try fetching the repositories again later. 

*UI Behavior*

I'd also want to ensure a smoother user experience when new repositories are fetched, by scrolling to whatever the latest repositories are in the Collection View once they have been fetched by the API.

