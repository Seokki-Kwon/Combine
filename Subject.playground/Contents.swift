import UIKit
import Combine

enum MyError: Error {
    case test
}

final class StringSubscriber: Subscriber {
    typealias Input = String
    
    typealias Failure = MyError
    
    func receive(subscription: any Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received value", input)
        // 3
        return input == "World" ? .max(1) : .none
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Received completion", completion)
    }
}

let subscriber = StringSubscriber()

// PassthroughSubject
// 필요에 따라서 새값을 게시
// 새값과 완료이벤트를 전달
let subject = PassthroughSubject<String, MyError>()

// Subject에 구독자를 구독시킴
subject.subscribe(subscriber)

// sink를 사용하여 다른 구독을 생성
let subscription = subject
    .sink(
       receiveCompletion: { completion in
         print("Received completion (sink)", completion)
       },
       receiveValue: { value in
         print("Received value (sink)", value)
       }
     )

subject.send("Hello")
subject.send("World")

subscription.cancel() // 구독취소


subject.send("Still there?") // 첫번째 구독자만 Still there?를 출력한다

subject.send(completion: .failure(MyError.test))
subject.send(completion: .finished) // 완료처리

subject.send("How about another one?") // 모든 구독자는 이이벤트를 받지않는다.

var subscriptions = Set<AnyCancellable>()

let currentSubject = CurrentValueSubject<Int, Never>(0)

currentSubject
    .print()
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)

currentSubject.send(1)
currentSubject.send(2)

print(currentSubject.value) // 값을 확인가능

// eraseToAnyPublisher
// 구독자에게 게시자에대한 세부 정보를 숨긴다?
let subject2 = CurrentValueSubject<Int, Never>(0)
let publisher = subject2.eraseToAnyPublisher()

publisher
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)



