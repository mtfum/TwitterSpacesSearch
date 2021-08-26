import SwiftUI
import ClientModels

struct SpaceView: View {

  let space: Model

  var body: some View {
    VStack {
      HStack {
        Text(space.state.rawValue)
          .font(.caption)
        Spacer()
        Text(format(date: space.startedAt))
          .font(.caption2)
      }
      Text(space.title)
        .font(.title2)
        .padding()

      HStack {
        Text("HOSTS:")
        Spacer()
        ForEach(space.hostUsers, id: \.id) { user in
          UserIconView(user: user)
        }
      }
      HStack {
        Text("SPEAKERS:")
        Spacer()
        ForEach(space.speakerUsers ?? [], id: \.id) { user in
          UserIconView(user: user)
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
    .padding()
  }

  private func format(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm E, d MMM"
    return formatter.string(from: date)
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
      self.title = space.title
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
