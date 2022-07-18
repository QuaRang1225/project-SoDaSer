import SwiftUI

struct TestView: View {
        @State var timeNow = ""
        @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        var dateFormatter: DateFormatter {
                let fmtr = DateFormatter()
                fmtr.dateFormat = "LLLL dd, hh:mm:ss a"
                return fmtr
        }
        
        var body: some View {
                Text("Currently: " + timeNow)
                        .onReceive(timer) { _ in
                                self.timeNow = dateFormatter.string(from: Date())
                        }
        }
}
