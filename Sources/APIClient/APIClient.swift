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
    session: @escaping () -> URLSession = { URLSession.shared },
    host: @escaping () -> String,
    headers: @escaping () -> [String: String],
    decoder: @escaping() -> JSONDecoder,
    delegate: (() -> URLSessionTaskDelegate?)? = nil
  ) {
    self.session = session()
    self.host = host()
    self.headers = headers()
    self.decoder = decoder()
    self.delegate = delegate?()
  }

  public func request<R: Decodable>(method: HTTPMethod, path: PathType, queryItems: [URLQueryItem]) async throws -> R {
    do {
      let request = try createURLRequest(method: method, path: path, queryItems: queryItems)
      let (data, response) = try await session.data(for: request, delegate: delegate)
      #if DEBUG
      print(response)
      print(String(data: data, encoding: .utf8)!)
      #endif
      let r = try decoder.decode(R.self, from: data)
      return r
    } catch {
      #if DEBUG
      print(error)
      #endif
      throw error
    }
  }

  private func createURLRequest(method: HTTPMethod, path: PathType, queryItems: [URLQueryItem] = []) throws -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path.rawValue
    components.queryItems = queryItems

    guard let url = components.url else { throw APIError.failedCreateURL }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    for (key, value) in headers {
      request.setValue(value, forHTTPHeaderField: key)
    }

    return request
  }
}

public enum APIError: Error {
  case failedCreateURL
}
