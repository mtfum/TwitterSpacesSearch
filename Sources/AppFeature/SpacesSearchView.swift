import SwiftUI
import TwitterModels

public struct SpacesSearchView: View {

  @StateObject private var viewModel = SpacesSearchViewModel()
  @State private var query = ""
  @State private var currentState = Space.State.live

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
      viewModel.getData(query: query, state: currentState)
    }
  }

  func mainView() -> some View {
    if viewModel.items.isEmpty {
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
        VStack {
          Picker("States", selection: $currentState) {
            ForEach(SpacesSearchViewModel.queryStates, id: \.self) { state in
              Text(state.rawValue)
                .tag(state)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          List {

            ForEach(viewModel.items, id: \.id) { space in
              SpaceView(space: space)
            }
          }
          .listStyle(.inset)
        }
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    SpacesSearchView()
  }
}
