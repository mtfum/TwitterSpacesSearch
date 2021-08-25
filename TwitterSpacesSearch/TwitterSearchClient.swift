//
//  TwitterSearchClient.swift
//  TwitterSearchClient
//
//  Created by Fumiya Yamanaka on 2021/08/24.
//

import Foundation

// search
// curl --location -g --request GET 'https://api.twitter.com/2/spaces/search?query=NBA&state=live' --header 'Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFkSTAEAAAAAtaGrbwdwVfUUMDilqk0R2vz%2BE8Y%3Db7J5yGN2MfpcPGHXgkbvjRJIg2iwLnE6lL2tnWHSaShXLv2mo5'
// {"data":[{"id":"1vOxwErRrWdGB","state":"live"}],"meta":{"result_count":1}}

// lookup
// curl --location -g --request GET 'https://api.twitter.com/2/spaces/1vOxwErRrWdGB?space.fields=host_ids,created_at,creator_id,id,lang,invited_user_ids,speaker_ids,started_at,state,title,updated_at,scheduled_start,is_ticketed' --header 'Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFkSTAEAAAAAtaGrbwdwVfUUMDilqk0R2vz%2BE8Y%3Db7J5yGN2MfpcPGHXgkbvjRJIg2iwLnE6lL2tnWHSaShXLv2mo5'
// {"data":{"title":"#NBA #Spurs #Basketball","is_ticketed":false,"creator_id":"1418282657964650498","started_at":"2021-08-24T22:33:13.000Z","lang":"en","created_at":"2021-08-24T22:33:10.000Z","host_ids":["1418282657964650498"],"state":"ended","updated_at":"2021-08-24T22:45:34.000Z","id":"1vOxwErRrWdGB"}}%

enum State: String, Decodable {
  case live, scheduled
}

struct SearchResponse: Decodable {
  let data: [Space]
  let meta: SearchMetaData
}

struct SearchMetaData: Decodable {
  let resultCount: Int
}

struct Space: Decodable, Identifiable {
  let id, title, lang, creatorId: String
  let updatedAt, createdAt, startedAt: Date
  let state: State
  let speakerIds, hostIds: [String]
  let isTicketed: Bool
}

final class TwitterSeachClient {

  let session = URLSession.shared
  let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()

  func searchSpaces(with query: String, state: State) async throws -> [Space] {
    let url = URL(string: "https://api.twitter.com/2/spaces/search?query=\(query)&state=\(state.rawValue)&space.fields=host_ids,created_at,creator_id,id,lang,invited_user_ids,speaker_ids,started_at,state,title,updated_at,scheduled_start,is_ticketed")!
    dump(url)

    var request = URLRequest(url: url)
    request.httpMethod  = "GET"
    request.setValue("Bearer \(Secret.twitterBearerToken)", forHTTPHeaderField: "Authorization")

    do {
      let (data, response) = try await session.data(for: request, delegate: nil)
      dump(String(data: data, encoding: .utf8))
      dump(response)

      return try decoder.decode(SearchResponse.self, from: data).data
    } catch {
      dump(error.localizedDescription)
      throw error
    }
  }
}
