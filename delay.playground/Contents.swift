import UIKit
import Combine

let delaySubject = PassthroughSubject<String, Never>()
var cancellables = Set<AnyCancellable>()

DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
    delaySubject.send("after 1 seconds")
}

DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
    delaySubject.send("after 2 seconds")
}

DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
    delaySubject.send("after 3 seconds")
}

delaySubject
    .delay(for: 5, scheduler: DispatchQueue.main)
    .sink(receiveValue: {str in
        print(str)
    })
    .store(in: &cancellables)
