//
//  File.swift
//  File
//
//  Created by Fumiya Yamanaka on 2021/08/25.
//

import Foundation

public typealias ID = String

public struct User: Decodable {
  public let id: ID
  public let name, username: String
  public let pinnedTweetId, location, userDescription: String?
  public let profileImageUrl: URL
  public let entities: Entities?
  public let createdAt: Date
  public let protected, verified: Bool
}

// MARK: - Entities
public struct Entities: Decodable {

  public struct Url: Codable {

    public struct Element: Codable {
      public let start, end: Int
      public let url, expandedUrl, displayUrl: String
    }

    public let urls: [Element]
  }

  public struct Description: Codable {

    public struct Hashtag: Codable {
      public let start, end: Int
      public let tag: String
    }

    public let hashtags: [Hashtag]
  }

  public let url: Url?
  public let entitiesDescription: Description?
}


#if DEBUG
extension User {
  public static let demo = User(
    id: "123",
    name: "John",
    username: "john123",
    pinnedTweetId: nil,
    location: nil,
    userDescription: "description description",
    profileImageUrl: URL(string: "https://pbs.twimg.com/profile_images/1428456204209164295/xo2wGWOQ_normal.jpg")!,
    entities: nil,
    createdAt: .now,
    protected: false,
    verified: false
  )
}
#endif
