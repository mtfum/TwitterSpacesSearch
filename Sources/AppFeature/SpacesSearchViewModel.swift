import SwiftUI
import TwitterService
import OrderedCollections

private let searchHistoryKey = "searchHistory"

@MainActor
final class SpacesSearchViewModel: ObservableObject {

  @Published private(set) var spaces: [SpaceView.Item] = []
  @Published private(set) var currentErrorMessage: String? = nil
  @Published private(set) var isSearching: Bool = false

  var histories: [String] {
    return UserDefaults.standard.object(forKey: searchHistoryKey) as? [String] ?? []
  }

  func getData(query: String) {
    Task {
      do {
        isSearching = true
        let response = try await TwitterService.search(query: query, state: .live)
        if let spaces = response.data, let users = response.includes?.users {
          let usersDictionary: [ID: User] = users.reduce(into: [:], { users, user in
            users[user.id] = user
          })

          self.spaces = spaces.map { SpaceView.Item(space: $0, users: usersDictionary) }
          currentErrorMessage = nil
          addHistory(query)
        } else {
          self.spaces = []
          if let error = response.errors?.first  {
            currentErrorMessage = error.detail ?? error.title ?? "ERROR!"
          } else {
            currentErrorMessage = "Currently there is no results.\nplease use another keyword!"
          }
        }
      } catch {
        self.spaces = []
        currentErrorMessage = error.localizedDescription
      }
      isSearching = false
    }
  }

  private func addHistory(_ query: String) {
    var histories = OrderedSet<String>(histories)
    histories.insert(query, at: 0)
    UserDefaults.standard.set(histories.elements, forKey: searchHistoryKey)
  }

}
