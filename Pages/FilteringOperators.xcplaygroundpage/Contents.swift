import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

example(of: "filter"){
    
    let numbers = (1...10).publisher
    
    numbers
        .filter{ $0.isMultiple(of: 3)}
        .sink(receiveValue: { n in
            print("\(n) is multiple of 3")
            
        })
        .store(in: &subscriptions)
}


example(of: "removeDuplicates"){
    
    let words = "hey hey dear! want to listen to mister mister ?"
        .components(separatedBy: " ")
        .publisher
    
    words
        .removeDuplicates()
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "compactMap"){
    
    let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher
    
    strings
        .compactMap{ Float($0)}
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
}

//ignoreoutput ignores the output published by the publisher and only handles the events completion
example(of: "ignoreOutput"){
    
    let numbers = (1...10000).publisher
    
    numbers
        .ignoreOutput()
        .sink(receiveCompletion: {
            print("completed with value \($0)")
        }, receiveValue: {print($0)})
        .store(in: &subscriptions)
    
}


example(of: "first(where:)"){
    
    let numbers = (1...9).publisher
    
    numbers
        .print()
        .first(where: {$0 % 2 == 0})
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
    
}


example(of: "last(where:)"){
    
    let numbers = (1...9).publisher
    
    numbers
        .last(where: { $0 % 2 == 0})
        .sink(receiveCompletion: {
            print("Completed with value \($0)")
        }, receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)
    
}


example(of: "last(where:)"){
    
    let numbers = PassthroughSubject<Int, Never>()
    
    numbers
        .last(where: { $0 % 2 == 0})
        .sink(receiveCompletion: {
            print("Completed with value \($0)")
        }, receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)
    
    numbers.send(1)
    numbers.send(2)
    numbers.send(3)
    numbers.send(4)
    numbers.send(5)
    numbers.send(completion: .finished)
    
}


//prefix allows to specify a number of values to receive before cancelling the subscription and completing.
example(of: "prefix"){
    let numbers = (1...9).publisher
    
    numbers
        .prefix(2)
        .sink(receiveCompletion: {
            print("Completed with \($0)")
        }, receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)
}


//drop allows to ignore values from publisher until certain condition specified is met
//it is just opposite of prefix where prefix prints values upto the condition and ignores all , drop ignores values to condition and prints output rest after.
example(of: "drop"){
    let numbers = (1...10).publisher
    
    numbers
        .drop(while: {$0 % 5 != 0})
        .sink(receiveCompletion: {
            print("Completed with value \($0)")
        }, receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)
}





//challenge filtering operators

example(of: "challenge filtering operators"){
    
    let numbers = (1...100).publisher
    
    numbers
        .dropFirst(50)
        .prefix(20)
        .filter{$0 % 2 == 0}
        .sink(receiveCompletion: {
            print("Completed with value \($0)")
        }, receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)
}

