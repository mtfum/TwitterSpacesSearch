import SwiftUI
import ClientModels

struct SpaceView: View {

  let space: Model

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      VStack(alignment: .leading, spacing: 4) {
        Text(space.title)
          .font(.title)
          .fontWeight(.medium)
        StateTimeView(state: space.state, startedAt: space.startedAt)
      }

      VStack(alignment: .leading, spacing: 0) {
        Text("Hosts")
          .font(.headline)

        HStack(alignment: .top) {
          ForEach(space.hostUsers, id: \.id) { user in
            UserIconView(user: user)
          }
        }
      }

      if space.speakerUsers?.isEmpty == false {
        VStack(alignment: .leading, spacing: 0) {
          Text("Speakers")
            .font(.headline)

          HStack(alignment: .top) {
            ForEach(space.speakerUsers ?? [], id: \.id) { user in
              UserIconView(user: user)
            }
          }
        }
      }

      Button(action: {
        print("sign up bin tapped")
      }) {
        ZStack {
          RoundedRectangle(cornerRadius: 48)
            .fill()
          Text("Join")
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(Font.title3)
            .padding()
            .foregroundColor(Color.white)
        }
        .frame(width: .infinity, height: 48)
        .padding()
      }
    }
  }
}

extension SpaceView {
  struct Model {
    let id, title, lang, creatorId: String
    let updatedAt, createdAt, startedAt: Date
    let state: ClientModels.State
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
