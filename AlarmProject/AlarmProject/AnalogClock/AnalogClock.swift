import SwiftUI
import Foundation

struct AnalogClock:View{
    
    @Binding var analogClock  : Bool
    
    init(analogClock:Binding<Bool> = .constant(false)){
        _analogClock = analogClock
    }
    
    var body: some View{
        ZStack{
            Image("NIGHT").resizable().edgesIgnoringSafeArea(.all)
            VStack{
                Banner(icon: "clock", color: Color.white, content: "시계").padding()
                ClockWindow().cornerRadius(20).padding()
            }
        }
        
        
    }
}
struct AnalogClock_Previews: PreviewProvider {
    static var previews: some View {
        AnalogClock()
    }
}
