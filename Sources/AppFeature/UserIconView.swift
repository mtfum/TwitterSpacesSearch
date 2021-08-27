import SwiftUI
import TwitterModels

struct UserIconView: View {

  let user: User

  var body: some View {
    AsyncImage(url: user.profileImageUrl) { image in
      image
        .resizable()
        .frame(width: 40, height: 40)
        .clipShape(Circle())
    } placeholder: {
      ProgressView()
    }
  }
}

struct UserIconView_Previews: PreviewProvider {
  static var previews: some View {
    UserIconView(user: .demo)
  }
}
