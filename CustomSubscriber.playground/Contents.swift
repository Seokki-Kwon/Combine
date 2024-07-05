import UIKit
import Combine

// Subscriber
// Publisher로 부터 input을 받을 수 있는 프로토콜

// Subscriber종류
// sink, assign, subscribe
// 게시자
let publisher = (1...6).publisher

// 커스텀구독자
final class IntSubscriber: Subscriber {
    typealias Input = Int
    
    typealias Failure = Never
    
    // 구독자는 최대 3개의 값을 수신함
    func receive(subscription: any Subscription) {
        subscription.request(.max(3))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value", input)
        // .unlimited -> 이벤트를 받을때마다 이벤트를 늘린다?
        return .none
    }
    // 완료 이벤트
    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
    }
}

let subscriber = IntSubscriber()

publisher.subscribe(subscriber)



