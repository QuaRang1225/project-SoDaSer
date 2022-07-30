
//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI


struct Alarm:View{
    
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var alarmAdd: Bool = false
    @State var contentAdd: Bool = false
    @State var button:String = "plus.app.fill"
    @State private var current = Date()
    @State var currentDate = Date()
    @State var timeName = String()
    @Binding var alarm : Bool
    
    
    @Environment(\.managedObjectContext) var mac
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Entity.time, ascending: true),NSSortDescriptor(keyPath: \Entity.alarmText, ascending: true)]) var timeList: FetchedResults<Entity>
 
    
    init(alarm:Binding<Bool> = .constant(false)){
        _alarm = alarm
        
    }
    var body: some View{
        ZStack{
            Image("NIGHT").resizable().edgesIgnoringSafeArea(.vertical).edgesIgnoringSafeArea(.horizontal)
            VStack{
                
                Text(FormatterClass.init().yearFormatter.string(from: currentDate)).font(.system(size: 25)).bold().foregroundColor(.white)
                           .onReceive(timer) { input in
                                self.currentDate = input
                               //print(FormatterClass.init().timeFormatter.string(from: currentDate))
                            }
                ZStack{
                    
                    Banner(icon: "alarm.fill", color: Color.white,content: "알람").frame(width: 400, height: 100)
                    Button(action:{
                        alarmAdd.toggle()
                        if alarmAdd{
                            button = "minus.square.fill"
                        }else{
                            button = "plus.app.fill"
                        }
                        
                        
                    }){
                        Image(systemName: button).font(.system(size: 50)).foregroundColor(.indigo).padding(40).padding(.leading,250)
                    }
                
                }.listRowSeparator(.hidden)
                Spacer()
                
                if alarmAdd{
                    ZStack{
                        HStack{
                            Spacer()
                            DatePickerWindow()
                            Spacer()
                        }.background(Color.white).cornerRadius(20)
                    }.padding().animation(.easeIn(duration: 0.2)).transition(.move(edge: .bottom))
                }

                
                List{
                    ForEach(timeList){ list in
                        
                        ZStack{
                            
                            HStack{ AlarmList(time: list.time ?? "" ,content: list.alarmText ?? "").onAppear(){
                                timeName = list.alarmText ?? ""
                            }}
                        }
                    }.onDelete(perform: deleteBooks)
                         
                }.listStyle(PlainListStyle())
                if contentAdd{
                    ZStack{
                        
                    }
                }

            }
        }
            
    }
    func deleteBooks(at offsets: IndexSet) {
        
        guard let index = offsets.first else { return }
        let times = timeList[index]
        mac.delete(times)
        try? mac.save()
        AlertAlarm().caancelAlarm(timeName: timeName)
    }
    
}
struct Alarm_Previews: PreviewProvider {
    static var previews: some View {
        Alarm()
    }
}

