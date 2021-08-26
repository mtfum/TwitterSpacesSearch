//
//  File.swift
//  File
//
//  Created by Fumiya Yamanaka on 2021/08/24.
//

import Foundation

public struct Space: Decodable {
  public let id, lang, creatorId: String
  public let title: String?
  public let updatedAt, createdAt, startedAt: Date
  public let state: State
  public let speakerIds: [String]?
  public let hostIds: [String]
  public let isTicketed: Bool
}

#if DEBUG
extension Space {
  public static let demo = Space(
    id: "123",
    lang: "Let's get started Space ",
    creatorId: "en",
    title: "creatorId",
    updatedAt: .now,
    createdAt: .now,
    startedAt: .now,
    state: .scheduled,
    speakerIds: ["a", "b", "c", "123"],
    hostIds: ["1", "2", "3", "123"],
    isTicketed: true
  )
}
#endif
