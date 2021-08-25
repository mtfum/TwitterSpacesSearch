// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "TwitterSpacesSearch",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "TwitterService", targets: ["TwitterService"])
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "AppFeature", dependencies: ["TwitterService"]),
    .target(name: "TwitterService", dependencies: ["APIClient", "ClientModels"]),
    .target(name: "APIClient", dependencies: []),
    .target(name: "ClientModels", dependencies: []),

    .testTarget(name: "TwitterSpacesSearchTests", dependencies: ["AppFeature"]),
  ]
)
