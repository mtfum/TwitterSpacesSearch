import SwiftUI
import TwitterService

public struct TwitterSpacesSearchView: View {

  @StateObject private var viewModel = ViewModel()

  public init() {}

  public var body: some View {
    List(viewModel.spaces, id: \.id) { space in
      SpaceView(space: .init(space: space, users: viewModel.users))
    }
    .task {
      do {
        try await viewModel.getData()
      } catch {
        dump(error.localizedDescription)
      }
    }
  }
}

class ViewModel: ObservableObject {
  @Published private(set) var spaces: [Space] = []
  @Published private(set) var users: [ID:User] = [:]

  func getData() async throws {
    let response = try await TwitterService.search(query: "Twitter", state: .live)

    spaces = response.data
    for user in response.includes.users {
      users[user.id] = user
    }
  }

  func filterUsers(space: Space) -> [User] {
    var fileterd: [User] = []
    let hostUsers = space.hostIds.compactMap { users[$0] }
    let speackerUsers = space.speakerIds?.compactMap { users[$0] } ?? []

    fileterd.append(contentsOf: hostUsers)
    fileterd.append(contentsOf: speackerUsers)

    return fileterd
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    TwitterSpacesSearchView()
  }
}
