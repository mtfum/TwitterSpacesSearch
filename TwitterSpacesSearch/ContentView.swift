//
//  ContentView.swift
//  TwitterSpacesSearch
//
//  Created by Fumiya Yamanaka on 2021/08/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ViewModel()

  var body: some View {
    List(viewModel.data) { d in
      HStack {
        Text(d.id)
          .fontWeight(.medium)
          .padding()
        Text(d.state)
          .fontWeight(.medium)
          .padding()
      }
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
  @Published private(set) var data: [SearchData] = []

  func getData() throws {
    Task {
      data = try await TwitterSeachClient().searchSpaces(with: "Twitter", state: .live)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
