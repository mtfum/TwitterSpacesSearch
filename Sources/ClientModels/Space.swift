//
//  File.swift
//  File
//
//  Created by Fumiya Yamanaka on 2021/08/24.
//

import Foundation

public struct Space: Decodable {
  public let id, title, lang, creatorId: String
  public let updatedAt, createdAt, startedAt: Date
  public let state: State
  public let speakerIds, hostIds: [String]
  public let isTicketed: Bool
}

#if DEBUG
extension Space {
  public static let demo = Space(
    id: "123",
    title: "Let's get started Space ",
    lang: "en",
    creatorId: "creatorId",
    updatedAt: .now,
    createdAt: .now,
    startedAt: .now,
    state: .scheduled,
    speakerIds: ["a", "b", "c"],
    hostIds: ["1", "2", "3"],
    isTicketed: true
  )
}
#endif
