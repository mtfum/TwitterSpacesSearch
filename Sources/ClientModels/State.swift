//
//  File.swift
//  File
//
//  Created by Fumiya Yamanaka on 2021/08/24.
//

import Foundation

extension Space {
  public enum State: String, Decodable {
    case live, scheduled, ended
  }
}
