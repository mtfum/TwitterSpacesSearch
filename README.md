# TwitterSpacesSearch

This repo is an experimental project of looking for Twitter Spaces iOS App.

I'm interested in new feature of Swift 5.5, especially Concurrency, and try to use new API in iOS 15 like [Searchable](https://developer.apple.com/documentation/swiftui/emptyview/searchable(text:placement:)).

Moreover, I've heared that Twitter has published [API v2](https://developer.twitter.com/en/docs/twitter-api). However, Twitter hasn't developed feature of searching spaces yet officially.

So this opportunity is like killing two birds with one stone for me.

# Requirements

- Xcode 13+
- iOS 15+

# Getting Started

- 1. Get source code: `$ git clone https://github.com/mtfum/TwitterSpacesSearch`
- 2. Go to directry: `$ cd TwitterSpacesSearch`
- 3. Prepare API Key:
  - go to [Twitter developer dashboard](https://developer.twitter.com/en/portal/dashboard) and copy you own Bearer Token
  - Paste your token to `YOUR_TOKEN` in `Secret.swift.sample`
  - Generate Secret file: `$ make secret`
- 4. Open the project: `TwitterSpacesSeach.xcworkspace`
- 5. Select `TwitterSpacesSearch` target in Xcode and Run(`⌘R`) (**you need more than iOS 15**)

# License


[license](https://github.com/mtfum/TwitterSpacesSearch/blob/main/LICENSE)
