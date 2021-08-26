import Foundation
@_exported import ClientModels
@_exported import APIClient


// search
// curl --location -g --request GET 'https://api.twitter.com/2/spaces/search?query=NBA&state=live' --header 'Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFkSTAEAAAAAtaGrbwdwVfUUMDilqk0R2vz%2BE8Y%3Db7J5yGN2MfpcPGHXgkbvjRJIg2iwLnE6lL2tnWHSaShXLv2mo5'
// {"data":[{"id":"1vOxwErRrWdGB","state":"live"}],"meta":{"result_count":1}}

// lookup
// curl --location -g --request GET 'https://api.twitter.com/2/spaces/1vOxwErRrWdGB?space.fields=host_ids,created_at,creator_id,id,lang,invited_user_ids,speaker_ids,started_at,state,title,updated_at,scheduled_start,is_ticketed' --header 'Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFkSTAEAAAAAtaGrbwdwVfUUMDilqk0R2vz%2BE8Y%3Db7J5yGN2MfpcPGHXgkbvjRJIg2iwLnE6lL2tnWHSaShXLv2mo5'
// {"data":{"title":"#NBA #Spurs #Basketball","is_ticketed":false,"creator_id":"1418282657964650498","started_at":"2021-08-24T22:33:13.000Z","lang":"en","created_at":"2021-08-24T22:33:10.000Z","host_ids":["1418282657964650498"],"state":"ended","updated_at":"2021-08-24T22:45:34.000Z","id":"1vOxwErRrWdGB"}}%


public enum Path: String, PathType {
  case search = "/2/spaces/search"
  case lookup = "/2/sppaces/lookup"
  case users = "/2/users"
}

public struct SearchResponse: Decodable {

  public struct UserResponse: Decodable {
    public let users: [User]
  }

  public struct SearchMetaData: Decodable {
    public let resultCount: Int
  }

  public let data: [Space]
  public let includes: UserResponse
  public let meta: SearchMetaData
}

public enum TwitterService {

  private static let expansions = "invited_user_ids,speaker_ids,creator_id,host_ids"
  private static let spaceFields = "host_ids,created_at,creator_id,id,lang,invited_user_ids,speaker_ids,started_at,state,title,updated_at,scheduled_start,is_ticketed"
  private static let userFields = "created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld"

  private static let client = APIClient.twitter

  public static func search(query: String, state: State) async throws -> SearchResponse {
    return try await client.request(
      method: .get,
      path: Path.search,
      queryItems: [
        .init(name: "query", value: query),
        .init(name: "state", value: state.rawValue),
        .init(name: "space.fields", value: spaceFields),
        .init(name: "expansions", value: expansions),
        .init(name: "user.fields", value: userFields)
      ]
    )
  }

}

extension APIClient {
  static let twitter: APIClient = APIClient.init(
    host: { "api.twitter.com" },
    headers: {
      return [
        "content-type": "application/json; charset=utf-8",
        "Authorization": "Bearer \(Secret.twitterBearerToken)"
      ]
    },
    decoder: decoder
  )
}

private let decoder = { () -> JSONDecoder in
  let decoder = JSONDecoder()
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
  decoder.dateDecodingStrategy = .formatted(dateFormatter)
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  return decoder
}
