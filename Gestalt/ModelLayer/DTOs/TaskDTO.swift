import Foundation

//private var numImagesPerGender = 6

struct TaskDTO {
    var brief: String?
    var full: String?
    var order: Int16?
    var due: Date?
    var suspended: Bool?
}

//
//extension TaskDTO: Deserializable {
//    
//    init(object: Outlaw.Extractable) throws {
//        let genderString: String = try object.value(for: "gender")
//        
//        age = try object.value(for: "age")
//        name = try object.value(for: "name")
//        password = try object.value(for: "password")
//        isIncognito = try object.value(for: "isIncognito")
//        imageName = randomImageName
//    }
//    
//    var randomImageName: String {
//        let imageIndex = Int(arc4random_uniform(UInt32(numImagesPerGender))) + 1
//                
//        return String(format: "Task%@%02d", imageGender, imageIndex)
//    }
//}
//
//extension TaskDTO: Serializable {
//    func serialized() -> [String: Any] {
//        return ["name": name,
//                "age": age,
//                "password": password,
//                "isIncognito": isIncognito,
//                "imageName": imageName]
//    }
//}
