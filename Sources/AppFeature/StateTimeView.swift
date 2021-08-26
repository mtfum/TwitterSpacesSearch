import SwiftUI
import ClientModels

struct StateTimeView: View {
  let state: ClientModels.State
  let startedAt: Date

  var body: some View {
    HStack(alignment: .center) {
      Text(state.rawValue.uppercased())
        .font(.caption)
        .fontWeight(.bold)
        .foregroundColor(color)
      Spacer()
      Text(dateString)
        .font(.caption2)
    }
  }

  var color: Color {
    switch state {
    case .live:
      return .red
    case .scheduled:
      return .accentColor
    case .ended:
      return .gray
    }
  }

  var dateString: String {
    switch state {
    case .live:
        let diffComponents = Calendar.current.dateComponents([.minute, .second], from: startedAt, to: .now)
        guard let min = diffComponents.minute else { return "" }
        return "\(min) min"
    case .scheduled:
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm E, d MMM"
      return formatter.string(from: startedAt)
    case .ended:
      return ""
    }
  }
}

struct StateTimeView_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        StateTimeView(state: .live, startedAt: .now)
        StateTimeView(state: .scheduled, startedAt: .now)
      }
    }
}
