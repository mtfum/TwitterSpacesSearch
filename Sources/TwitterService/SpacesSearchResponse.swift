//
//  File.swift
//  File
//
//  Created by Fumiya Yamanaka on 2021/08/26.
//

import Foundation


public struct SpacesSearchResponse: Decodable {

  public struct UserResponse: Decodable {
    public let users: [User]
  }

  public struct SearchMetaData: Decodable {
    public let resultCount: Int
  }

  public struct Error: Decodable {
    public let detail: String?
    public let status: Int?
    public let title: String?
    public let type: String?
  }

  public let data: [Space]?
  public let includes: UserResponse?
  public let meta: SearchMetaData?
  public let errors: [Error]?
}
