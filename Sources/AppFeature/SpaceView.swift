import SwiftUI
import TwitterModels

struct SpaceView: View {

  @Environment(\.openURL) var openURL

  let space: Item

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      VStack(alignment: .leading, spacing: 4) {
        Text(space.title)
          .font(.title)
          .fontWeight(.medium)
        StateTimeView(state: space.state, startedAt: space.startedAt)
      }

      createUsersView(title: "Hosts", users: space.hostUsers)

      if let users = space.speakerUsers, !users.isEmpty {
        createUsersView(title: "Speakers", users: users)
      }

      Button(action: {
        if let url = URL(string: "https://twitter.com/i/spaces/\(space.id)") {
          openURL(url)
        }
      }) {
        ZStack {
          RoundedRectangle(cornerRadius: 48)
            .fill()
          Text("Join")
            .font(Font.title3)
            .padding()
            .foregroundColor(Color.white)
        }
        .frame(height: 48)
        .padding()
      }
    }
  }

  func createUsersView(title: String, users: [User]) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title)
        .font(.headline)
      ScrollView(.horizontal) {
        HStack(spacing: 8) {
          ForEach(users, id: \.id) { user in
            UserIconView(user: user)
          }
        }
      }
    }
  }

}

extension SpaceView {
  struct Item {
    let id, title, lang, creatorId: String
    let updatedAt, createdAt, startedAt: Date
    let state: Space.State
    let speakerUsers: [User]?
    let hostUsers: [User]
    let isTicketed: Bool

    init(space: Space, users: [ID:User]) {
      self.id = space.id
      self.title = space.title ?? ""
      self.lang = space.lang
      self.creatorId = space.creatorId
      self.updatedAt = space.updatedAt
      self.createdAt = space.createdAt
      self.startedAt = space.startedAt
      self.state = space.state
      self.speakerUsers = space.speakerIds?.compactMap { users[$0] }
      self.hostUsers = space.hostIds.compactMap { users[$0] }
      self.isTicketed = space.isTicketed
    }
  }
}

struct SpaceView_Previews: PreviewProvider {
  static var previews: some View {
    SpaceView(space: .init(space: .demo, users: ["123": .demo]))
  }
}
