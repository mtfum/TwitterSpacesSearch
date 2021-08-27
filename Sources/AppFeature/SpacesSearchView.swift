import SwiftUI

public struct SpacesSearchView: View {

  @StateObject private var viewModel = SpacesSearchViewModel()
  @State private var query = ""

  public init() {}

  public var body: some View {
    NavigationView {
      mainView()
        .navigationTitle("Spaces Search")

    }.searchable(text: $query, suggestions: {
      ForEach(viewModel.histories, id: \.self) {
        Text($0).searchCompletion($0)
      }
    })
    .onSubmit(of: .search) {
      viewModel.getData(query: query)
    }
  }

  func mainView() -> some View {
    if viewModel.spaces.isEmpty {
      if viewModel.isSearching {
        return AnyView(ProgressView())
      } else {
        if let message = viewModel.currentErrorMessage {
          return AnyView(Text(message).fontWeight(.medium))
        } else {
          return AnyView(Text("Let's search spaces!").fontWeight(.medium))
        }
      }
    } else {
      return AnyView(
        List {
          ForEach(viewModel.spaces, id: \.id) { space in
            SpaceView(space: space)
          }
        }
          .listStyle(.inset)
      )
    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    SpacesSearchView()
  }
}
