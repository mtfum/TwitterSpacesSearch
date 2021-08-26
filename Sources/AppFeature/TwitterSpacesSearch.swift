import SwiftUI
import TwitterService

public struct TwitterSpacesSearchView: View {

  @StateObject private var viewModel = ViewModel()

  public init() {}

  public var body: some View {
    NavigationView {
      List(viewModel.spaces, id: \.id) { space in
        SpaceView(space: .init(space: space, users: viewModel.users))
          .disabled(true)
      }
      .listStyle(.inset)
      .navigationTitle("Spaces Search")
      .task {
        do {
          try await viewModel.getData()
        } catch {
          dump(error.localizedDescription)
        }
      }
    }
  }
}

@MainActor
final class ViewModel: ObservableObject {
  @Published private(set) var spaces: [Space] = []
  @Published private(set) var users: [ID:User] = [:]

  func getData() async throws {
    let response = try await TwitterService.search(query: "Twitter", state: .live)

    spaces = response.data
    for user in response.includes.users {
      users[user.id] = user
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    TwitterSpacesSearchView()
  }
}
