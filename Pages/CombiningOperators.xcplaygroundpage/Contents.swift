import Foundation
import Combine


var subscriptions = Set<AnyCancellable>()

//prepend - works on a variadic list of values and prepends that list onto the original publisher
// as append adds the value to the end of the list prepend adds the values to the start of the list or colletion

example(of: "prepend(Output)"){
    
    let publisher = [3,4].publisher
    
    publisher
        .prepend(1,2)
        .prepend(-1,0)
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
    
}


example(of: "prepend(Sequence)"){
    
    let publisher = [5,6,7].publisher
    
    publisher
        .prepend([3,4])
        .prepend(Set(1...2))
        .prepend(stride(from: 6, to: 15, by: 2)) //Stridable conforms to sequence
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
}


example(of: "prepend(Publisher)"){
    
    let publisher1 = [3,4].publisher
    
    let publisher2 = [1,2].publisher
    
    publisher1
        .prepend(publisher2)
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
    
}

example(of: "prepend(Publisher) #2"){
    
    let publisher1 = [3,4].publisher
    
    let publisher2 = PassthroughSubject<Int, Never>()
    
    publisher1
        .prepend(publisher2)
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
    
    publisher2.send(1)
    publisher2.send(2)
    publisher2.send(completion: .finished)
}



//append
example(of: "append(Output)"){
    
    let publisher = [1].publisher
    
    publisher
        .append(2,3)
        .append(4)
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
    
}

example(of: "append(Sequence)"){
    
    let publisher = [1,2,3].publisher
    
    publisher
        .append([4,5])
        .append(Set([6,7]))
        .append(stride(from: 8, to: 11, by: 2)) //Stridable conforms to sequence
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
}

example(of: "append(Publisher) #2"){
    
    let publisher2 = PassthroughSubject<Int, Never>()
    
    publisher2
        .append(3,4)
        .append(5)
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
    
    publisher2.send(1)
    publisher2.send(2)
    publisher2.send(completion: .finished)
}

example(of: "append(Publisher)"){
    
    let publisher1 = [1,2].publisher
    
    let publisher2 = [3,4].publisher
    
    publisher1
        .append(publisher2)
        .sink(receiveValue: {print($0)})
        .store(in: &subscriptions)
    
}



//challenge append and prepend

example(of: "challenge append prepend"){
    
    let phoneNumbersPublisher = ["123-4567"].publisher
    let areaCode = "410"
    let phoneExtension = "901"
    
    phoneNumbersPublisher
        .prepend("1-", areaCode, "-")
        .append("EXT")
        .append(phoneExtension)
        .collect()
        .sink(receiveValue: {print($0.joined())})
        .store(in: &subscriptions)
    
}


//Complex Combining Operators

example(of: "switchToLatest"){
    
    let publisher1 = PassthroughSubject<Int, Never>()
    
    
}
