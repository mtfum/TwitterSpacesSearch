import SwiftUI
import ClientModels

struct UserIconView: View {

  let user: User

  var body: some View {
    AsyncImage(url: user.profileImageUrl)
      .padding()
      .clipShape(Capsule())
  }
}

struct UserIconView_Previews: PreviewProvider {
  static var previews: some View {
    UserIconView(user: .demo)
  }
}
