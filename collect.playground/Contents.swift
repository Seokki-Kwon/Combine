import Combine

// collect
// 개별요소 -> 배열
// collect -> ["A", "B", "C", "D", "E"]
// collect(2) -> ["A", "B"] -> ["C", "D"] -> ["E"]
["A", "B", "C", "D", "E"].publisher
    .collect(2)
    .sink(receiveCompletion: {
        print($0)
    }, receiveValue: {
        print($0)
    })
