//
//  PreViewProvider.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/25.
//

import Foundation
import SwiftUI
import CoreLocation

extension PreviewProvider{
    static var dataSet:CustomPreView{
        return CustomPreView.instance
    }
}

class CustomPreView{
    static let instance = CustomPreView()
    let regInfo = Register(name: "콰랑",status: true)
    let post = Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date()))
    let postView = [
        Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date())),
        Post( id: 1, user: "dbduddnd@gmail.com", title: "좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date())),
        Post( id: 1, user: "dbduddnd@gmail.com", title: "좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date())),
        Post( id: 1, user: "dbduddnd@gmail.com", title: "좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date()))
    ]
    let feedView = [
        Feed(user: UserData(email: "dbduddnd1225@gmail.com", name: "유영웅", nickname: "quarang", profileImage: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG"), post: Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date()))),
        Feed(user: UserData(email: "dbduddnd1225@gmail.com", name: "유영웅", nickname: "quarang", profileImage: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG"), post: Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date()))),  Feed(user: UserData(email: "dbduddnd1225@gmail.com", name: "유영웅", nickname: "quarang", profileImage: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG"), post: Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date()))),  Feed(user: UserData(email: "dbduddnd1225@gmail.com", name: "유영웅", nickname: "quarang", profileImage: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG"), post: Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date()))),  Feed(user: UserData(email: "dbduddnd1225@gmail.com", name: "유영웅", nickname: "quarang", profileImage: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG"), post: Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date()))),  Feed(user: UserData(email: "dbduddnd1225@gmail.com", name: "유영웅", nickname: "quarang", profileImage: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG"), post: Post( id: 1, user: "dbduddnd@gmail.com", title: "너무너무좋다" ,category: "가족", contents: String.dummyString, image: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG", longitude: 127.35479993764466, latitude: 36.29890548178076, createTime: DateFormatter().string(from: Date())))
    ]
    let imageArr = [
        "https://i3.ruliweb.com/img/5/5/8/1/55814F5D3352EB001F",
        "https://i1.ruliweb.com/img/5/5/8/1/55814F5B3351CB0022"
    ]
    let user  = UserData(email: "dbduddnd1225@gmail.com", name: "유영웅", nickname: "quarang", profileImage: "https://data.onnada.com/character/201611/3696359636_c30df81f_08-325D.JPG")
    let favorite = Favorite(keyWord: "교통", city: "대전광역시", location: "가수원동 807-6", lat: 36.29890548178076, long: 127.35479993764466, title: "우리집",image: FavoriteFilter.bus.imageName)
    
    let followList = [
        Follow(user: "dbduddnd1225@gmail.com", targetUser: "quarang@gmail.com"),
        Follow(user: "dbduddnd1225@gmail.com", targetUser: "quarang@gmail.com"),
        Follow(user: "dbduddnd1225@gmail.com", targetUser: "quarang@gmail.com"),
        Follow(user: "dbduddnd1225@gmail.com", targetUser: "quarang@gmail.com"),
        Follow(user: "dbduddnd1225@gmail.com", targetUser: "quarang@gmail.com")
    ]
    
}
extension String{
    static let dummyString = "우리 천고에 그러므로 주는 심장은 부패뿐이다. 찬미를 피어나기 구하지 발휘하기 보는 아니더면, 사막이다. 밥을 청춘의 이것이야말로 이상 두손을 인간에 많이 노래하며 교향악이다. 쓸쓸한 행복스럽고 놀이 뜨고, 것이다. 투명하되 우리 가지에 보는 현저하게 사막이다. 보배를 청춘 뼈 사막이다. 위하여서 피에 밥을 얼마나 인생을 청춘 같지 아니한 피다. 천지는 가치를 반짝이는 황금시대를 소리다.이것은 웅대한 현저하게 풀이 기관과 봄바람이다. 군영과 그들은 것은 사라지지 듣는다. 할지니, 있을 창공에 모래뿐일 뼈 트고, 끓는 칼이다. 인류의 얼마나 무엇을 하는 공자는 긴지라 피가 그와 것은 있다. 되는 몸이 구하기 노래하며 풍부하게 너의 온갖 안고, 운다. 석가는 있는 영원히 인간의 지혜는 사막이다. 이상, 목숨을 같으며, 눈에 영원히 꽃 보라. 천지는 평화스러운 가치를 이것이다. 원대하고, 품으며, 바이며, 이상은 꾸며 위하여서 봄바람이다. 있으며, 살 바이며, 것이다. 이것을 얼마나 동산에는 말이다. 하였으며, 청춘이 이상의 청춘의 무엇을 주며, 뼈 생명을 듣는다. 찾아다녀도, 청춘의 발휘하기 놀이 스며들어 생의 하였으며, 있는 열락의 것이다. 지혜는 남는 과실이 행복스럽고 운다. 싶이 따뜻한 이상, 품고 피가 타오르고 그들의 사람은 봄바람이다. 주는 그들은 피가 속에 동력은 영원히 이상, 듣는다. 살았으며, 황금시대를 방황하여도, 들어 많이 우리는 위하여서. 청춘 따뜻한 얼음 위하여서. 무엇을 따뜻한 있을 하였으며, 우리 어디 보라. 군영과 것은 얼음이 용감하고 뜨거운지라, 그리하였는가? 가슴에 인간은 이상 만천하의 끓는다. 이상 실현에 되는 우리는 뜨거운지라, 이상을 우리 소담스러운 웅대한 황금시대다. 인생을 얼마나 희망의 얼마나 품고 이상은 살았으며, 보배를 이것이다. 그들을 피가 것이 인간에 것이다. 대한 끓는 내려온 곳이 힘차게 듣는다. 얼음 우리의 창공에 열락의 것이다. 풍부하게 인류의 끝에 따뜻한 넣는 미묘한 그들의 맺어, 철환하였는가? 이상 밝은 실현에 생명을 피가 인생에 힘차게 그들의 것이다. 눈에 동력은 과실이 가지에 일월과 충분히 고동을 가장 주며, 황금시대다. 만물은 때에, 희망의 있다. 열매를 예수는 용기가 물방아 되려니와, 청춘의 뜨거운지라, 때문이다. 그들에게 착목한는 풀이 청춘의 청춘의 봄날의 영원히 보이는 봄바람이다. 거선의 않는 영락과 사라지지 못하다 그것을 있다. 어디 고동을 같지 철환하였는가? 아름답고 청춘의 동력은 품고 설산에서 희망의 약동하다. 눈이 그와 군영과 뼈 같이, 아름답고 있는가? 그러므로 찾아다녀도, 때까지 보내는 영락과 것은 위하여 것이다. 쓸쓸한 오아이스도 청춘의 관현악이며, 구하기 그것을 못할 이상의 인생을 것이다. 평화스러운 끝까지 것은 든 속에 더운지라 이것을 돋고, 이것이다. 부패를 가슴에 보배를 힘있다. 가는 황금시대를 하였으며, 지혜는 피다. 몸이 열락의 생명을 것이다. 평화스러운 어디 꽃 말이다. 아름답고 방지하는 찬미를 뿐이다. 인생에 그와 심장의 공자는 간에 목숨이 수 생명을 이것이다. 수 모래뿐일 방황하였으며, 그들의 밝은 대고, 인생을 안고, 풀이 쓸쓸하랴? 위하여 설산에서 보이는 얼마나 따뜻한 것이다. 굳세게 밥을 장식하는 눈이 봄바람이다. 우는 무엇이 인간에 있는 목숨을 때에, 옷을 보내는 이것이다. 무엇을 청춘은 가진 이것이다. 것이 설레는 생생하며, 이는 황금시대의 때문이다. 인류의 수 피어나기 청춘의 말이다."
}

extension UIScreen{
    static let photoWidth = UIScreen.main.bounds.width
}
