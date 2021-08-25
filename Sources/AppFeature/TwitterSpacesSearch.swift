import SwiftUI
import TwitterService

public struct TwitterSpacesSearchView: View {

  @StateObject private var viewModel = ViewModel()

  public init() {}

  public var body: some View {
    List(viewModel.spaces, id: \.id) { space in
      SpaceView(space: space)
    }
    .task {
      do {
        try viewModel.getData()
      } catch {
        dump(error.localizedDescription)
      }
    }
  }
}

class ViewModel: ObservableObject {
  @Published private(set) var spaces: [Space] = []

  func getData() throws {
    Task {
      spaces = try await TwitterService.search(query: "Twitter", state: .live).data
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    TwitterSpacesSearchView()
  }
}
