import Foundation
@_exported import TwitterModels
@_exported import APIClient

public enum Path: String, PathType {
  case search = "/2/spaces/search"
  case lookup = "/2/sppaces/lookup"
}

public enum TwitterService {

  private static let expansions = "invited_user_ids,speaker_ids,creator_id,host_ids"
  private static let spaceFields = "host_ids,created_at,creator_id,id,lang,invited_user_ids,speaker_ids,started_at,state,title,updated_at,scheduled_start,is_ticketed"
  private static let userFields = "created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld"

  private static let client = APIClient.twitter

  public static func search(query: String, state: Space.State) async throws -> SpacesSearchResponse {
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
