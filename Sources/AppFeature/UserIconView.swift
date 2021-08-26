import SwiftUI
import ClientModels

struct UserIconView: View {

  let user: User

  var body: some View {
    VStack(alignment: .center) {
      AsyncImage(url: user.profileImageUrl) { image in
        image
          .resizable()
          .frame(width: 40, height: 40)
          .clipShape(Circle())
      } placeholder: {
        ProgressView()
      }
      Text(user.name)
        .font(.caption)
        .lineLimit(1)
    }
      .padding()
  }
}

struct UserIconView_Previews: PreviewProvider {
  static var previews: some View {
    UserIconView(user: .demo)
  }
}
