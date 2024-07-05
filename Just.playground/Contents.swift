import UIKit
import Combine

// Just
// 구독자에게 한번씩만 출력을 내보냄
let just = Just("Hello world!")

// sink -> AnyCancellable
just.sink {
    print("Completion Recieved", $0)
} receiveValue: {
    print("Recieved value", $0)
}

// AnyCancellable 취소가능한 타입? Disposable 같은 개념인듯

// assign
// 특정 객체 속성에 값을 할당
// keyPath 방식과 Published에 할당하는 방법
let publisher = ["Hello", "world!"].publisher

class SomeObject {
    var value: String = "" {
        didSet {
            print(value)
        }
    }
}

let object = SomeObject()

publisher
    .assign(to: \.value, on: object)
    .cancel()

class SomeObject2 {
    @Published var value = ""
}

let object2 = SomeObject2()

object2.$value
    .sink {
        print("Changed value", $0)
    }

publisher
    .assign(to: &object2.$value)

