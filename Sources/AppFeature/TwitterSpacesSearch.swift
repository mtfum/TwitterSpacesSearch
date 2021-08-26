import SwiftUI
import TwitterService

public struct TwitterSpacesSearchView: View {

  @StateObject private var viewModel = ViewModel()
  @State private var query = ""

  public init() {}

  public var body: some View {
    NavigationView {
      if viewModel.spaces.isEmpty {
        Text("Let's Search your Spaces!")
          .navigationTitle("Spaces Search")
      } else {
        List(viewModel.spaces, id: \.id) { space in
          SpaceView(space: space)
        }
        .listStyle(.inset)
        .navigationTitle("Spaces Search")
      }
    }
    .searchable(text: $query, suggestions: {
//      ForEach(viewModel.histories, id: \.self) { Text($0).searchCompletion($0) }
    })
    .onSubmit(of: .search) {
      Task {
        try await viewModel.getData(query: query)
      }
    }
  }
}

@MainActor
final class ViewModel: ObservableObject {
  @Published private(set) var spaces: [SpaceView.Item] = []

  func getData(query: String) async throws {
    let response = try await TwitterService.search(query: query, state: .live)
    let users: [ID: User] = response.includes.users.reduce(into: [:], { users, user in
      users[user.id] = user
    })

    spaces = response.data.map { SpaceView.Item(space: $0, users: users) }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    TwitterSpacesSearchView()
  }
}
