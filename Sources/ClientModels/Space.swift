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
