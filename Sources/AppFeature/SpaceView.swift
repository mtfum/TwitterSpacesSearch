import SwiftUI
import ClientModels

public struct SpaceView: View {

  let space: Space

  public var body: some View {
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
        ForEach(space.hostIds, id: \.self) { id in
          HStack {
            Text(id)
          }
        }
      }
      HStack {
        Text("SPEAKERS:")
        Spacer()
        ForEach(space.speakerIds, id: \.self) { id in
          HStack {
            Text(id)
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
        .frame(width: .infinity, height: 48, alignment: .center)
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

struct SpaceView_Previews: PreviewProvider {
  static var previews: some View {
    SpaceView(space: .demo)
  }
}
