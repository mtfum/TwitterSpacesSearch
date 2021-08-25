//
//  File.swift
//  File
//
//  Created by Fumiya Yamanaka on 2021/08/24.
//

import Foundation

public protocol PathType {
  var rawValue: String { get }
}

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

public struct APIClient {
  let session: URLSession
  let host: String
  let headers: [String:String]
  let decoder: JSONDecoder
  let delegate: URLSessionTaskDelegate?

  public init(
    session: @escaping () -> URLSession,
    host: @escaping () -> String,
    headers: @escaping () -> [String: String],
    decoder: @escaping() -> JSONDecoder,
    delegate: @escaping (() -> URLSessionTaskDelegate?)
  ) {
    self.session = session()
    self.host = host()
    self.headers = headers()
    self.decoder = decoder()
    self.delegate = delegate()
  }

  public func request<R: Decodable>(method: HTTPMethod, path: PathType, queryItems: [URLQueryItem]) async throws -> R {
    do {
      let url = try createURL(method: method, path: path)
      let (data, _) = try await session.data(from: url, delegate: delegate)
      let r = try decoder.decode(R.self, from: data)
      return r
    } catch {
      throw error
    }
  }

  private func createURL(method: HTTPMethod, path: PathType, queryItems: [URLQueryItem] = []) throws -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path.rawValue
    components.queryItems = queryItems
    guard let url = components.url else { throw NSError() }
    return url
  }
}
