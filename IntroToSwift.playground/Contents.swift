/*:
# Intro to Swift
*/

import Foundation
//import UIKit

//: ## Variables and constanst
var size: Float = 42.0
var answer = 42
let name = "Anakin"

//: All is an "Object"
Int.max
Double.abs(-42.0)

//: ## Conversions
let a = Int(size)
let ans = String(answer)
//let sizef :Int = Int("")

//: ## typealias: to give another name to types

typealias Integer = Int
// now Integer means Int

let a1 : Integer = 42;

//: ## Collections
var swift = "New Apple Language"
swift = swift + "!"

//  Array
var words = [ "manzana", "pepinillo", "patata", "pera", "uva" ]
words[0]

// Dictionary
let numberNames  = [1: "one", 2: "two"]
numberNames[2]


//: ## Iterate
var total = ""
for element in words {
    total = "\(total) \(element)"
}

print(total)

total = ""
for element in [1,2,3,4,5,6,7,8] {
    total = "\(total) \(element)"
}

print(total)

for(key, value) in numberNames {
    print ("\(key) \(value)")
}

/****/

//: Functions
func h(perico a:Int, deLosPalotes b: Int) -> Int {
    return (a+b) * a
}

//h(3,b: 4)
h(perico: 3, deLosPalotes: 3)


// functions without external names:
// anonimous variable _
func f(a: Int, _ b: Int) -> Int {
    return (a+b)
}

f(3,2)



func sum(a:Int, _ b: Int, thenMultyplyBy c:Int) ->Int {
    return (a+b) * c
}

sum(3, 4, thenMultyplyBy: 5)

// Default values
func addSuffixTo(a:String, suffix:String = "ingly") -> String{
    return a + suffix
}

addSuffixTo("accord")
addSuffixTo("Objetive-", suffix: "C")


// Return values

func namesOfNumber(a:Int) -> (Int, String, String) {
    var val:(Int, String, String)
    switch a {
    case 1:
        val = (1,"one", "uno")
    case 2:
        val = (2, "two", "dos")
    default:
        val = (a, "Ask Google, idiot", "Pregunta a Google, idiota")
    }
    return val
}

let r = namesOfNumber(2)

let (_, en, es) = namesOfNumber(1)

en
es

(es, en)

//: ## High level functions
typealias IntToIntFunc = (Int) -> Int
var z: IntToIntFunc

// typealias: Also useful to create ghost types

// Functions as parameters

func apply(f: IntToIntFunc, n : Int) -> Int {
    return f(n)
}

func doubler(a: Int) -> Int  {
    return a*2
}

func add42(a: Int) -> Int {
    return a+42
}

apply(doubler, n:4)


// Functions as return values

func compose(f: IntToIntFunc, _ h: IntToIntFunc ) -> IntToIntFunc {
    // functions inside functions ??
                func comp(a:Int) ->Int {
                    return f(h(a))
                }
                return comp
}
compose(add42, doubler)(8)

let comp = compose(add42, doubler)

// Functions with same type, in an array
var funcs = [add42, doubler, comp]

for f in funcs {
    f(33)
}

//: ## Closure Syntas: literal representation of functions
func g(a:Int) -> Int {
    return a + 42
}
// It's exactly the same as

let gg = {
    (a:Int) -> Int in
    return a + 42
}

g(1)
gg(1)

// Closures simplified syntax
let closures = [
    g,
    {(a:Int) -> Int in
            return a-42},
    {a in
        return a+45},
    {a in a / 42},
    {$0 * 42}
]

typealias BynaryFunc = (Int, Int) -> Int
let applier = {
    (f: BynaryFunc, m: Int, n: Int) -> Int in
        return f(m,n)
}

applier(*,2,4)

// Trailing clousure
func applierInv(m:Int, n: Int, f: BynaryFunc) -> Int {
    return applier(f,m,n)
}
/*

let c = applierInv(2, 4, f: {$0 * 2 + $1 * 3})

// 100% equivalent to:
let cc = applierInv(2,4){
    return $0 * 2 + $1 * 3
}
*/

//: ## Optionals

// Pack something inside an optional

var maybeString: String? = "I'm a boxed!"

var maybeAnInt: Int?

print (maybeString)
print(maybeAnInt)

// Unpack

// Secure way
if let certainlyAString = maybeString {
    print("Told you it was a string")
    print(certainlyAString)
}

// Brutal force way
var thereIGo = maybeAnInt//!


//: Aggregate types: enums, structs, classes, tuples

enum LightSableColor {
    case Blue, Red, Green, Purple
}


struct LightSable {
    // static or class property (stored)
    static let quote = "An elegant weapon for a more civilized time"
    
    // Instance properties
    var color : LightSableColor = .Blue {
        // Property observer
        willSet(newValue) {
            print("About to change color to \(newValue)")
        }
    }
    
    var isDoubleBladed = false;
}

// If can be a default value, use it
// If not, create init
// only use optionals when needed
// Don't use ! unless you really know what you're doing (app will crash if finds null)

class Jedi: NSObject {//: CustomStringConvertible{
    //  Stored properties
    //var lightSable = LightSable(color: .Blue, isDoubleBladed: false)) // create struct new instance
    var lightSable = LightSable() // create struct new instance
    
    var name : String
    var midichlorians = 1_000
    
    var master : Jedi?
    var padawan : Jedi?
    
    // Computed property
    var fullName : String {
        get {
            var full = ""
            if let m = master {
                full = full + " padawan of \(m.name)"
            }
            return full
        }
    }
    
    // Initializators
    init (name : String,
        midichlorians : Int,
        lightSable :  LightSable,
        master : Jedi?,
        padawan : Jedi?) {
            // Using patttern matching 
            (self.name, self.midichlorians, self.lightSable) = (name, midichlorians, lightSable)
            
            // REst normal
            self.master = master
            self.padawan = padawan
            
            // no return needed, except with error handling
    }
    
    // convenience
    convenience init (name: String) {
        self.init(name: name, midichlorians: 1000,
            lightSable: LightSable(),
            master: nil, padawan: nil)
    }
    
    convenience init (masterName name: String) {
        self.init(name: name, midichlorians: 10_000,
            lightSable: LightSable(color: .Green, isDoubleBladed: false),
            master: nil, padawan: nil)
    }
    
    // Regular method
    func totalMidichlorians() -> Int {
        var total = midichlorians
        if let masterMidichlorians = master?.midichlorians {
            total = total + masterMidichlorians
        }
        return total
    }
}


let luke = Jedi(masterName: "Luke Skywalker")

// Inheritance
class Sith: Jedi {
    //var alias : String?
    //init()
    convenience init(sithName name: String ){
        self.init(name: name, midichlorians: 1000,
            lightSable: LightSable(color: .Red, isDoubleBladed: true),
            master: nil, padawan: nil)
    }
    
}


//: Extensions
typealias Euro = Double

extension Euro {
    var €: Double {
        return self
    }
    var $: Double {
        return self * 0.7
    }
}

var totalEuros = 123.€ + 45.09.$


typealias Task = () -> ()
extension Int {
    func times (task: Task) {
        for _ in 1...self{
            task()
        }
    }
}

4.times {
    print("My name is Groot")
}


//: Nil and tuple

// 2-tuples
(2, "hola")

// tuple inside tuple

(45, ("Hola", NSDate()), 45)

//1-tuple does not exists
(2) == 2

//0-tuple represents nil 

func p () {
    print ("Hola Mundo")
}

func pp() ->(){
    print("Hola caracola")
}


//: Get type on execution time 
43.9.dynamicType



//: ## Error handling

// Before apple solution
enum Result {
    // Cases have not the same type
    case error(NSError)
    case success(Int)
}

// After apple solution
// Wordies: try, throw/s, catch, do

// Any function which can generate error, is marked with throw
// Any function which throws error has to be called with try

//let err : ErrorType

func inverse(n: Double) throws -> Double {
    guard n != 0 else {
        throw NSError(domain: "Division by zero", code: 42, userInfo: nil)
    }
    return 1 / n
}

try inverse(42)

do { // Create new environment
    let inv = try inverse(42)
} catch {
    print("Fail")
}

// Variations in try
//try! inverse(8) // if error, app crashes

try? inverse(0) // No need to catch error


//: ### Init with failures
/*
class Thing: NSObject {
    
    let url : NSURL
    
    init?(urlString: String) {
        let theUrl = NSURL(string: urlString)
        if theUrl == nil {
            // Failed, return nil
            return nil
        } else {
            url = theUrl!
        }
        super.init()
    }
}

let t = Thing(urlString: "no url")


//: Casts in Swift
class Thong : Thing{}

let tt = Thing(urlString: "https://www.google.com")

let ttt = tt as? Thong // good mood

//let tttt = tt as! Thong // by force
*/

//: ### Optional Chaining
let n : String? = "Anakin Skywalker"
let firstName = n?.componentsSeparatedByString(" ")[0]
print(firstName)
let length = firstName?.characters.count
let uppercaseName = firstName?.uppercaseString

let maybeAFloat: Optional<Float> // Without sintactic sugar Float?


// Optional unpack implicit way

var msg : String! = "Hola Swift"
print(msg)
// no need of ?: Can be used when there's something in the optional. 
// Otherwise, app will crash
msg.uppercaseString


var catacrac : Float!
//print(catacrac) // A fregar

// USE: When you want the app to crash if something fails. Used in tests


