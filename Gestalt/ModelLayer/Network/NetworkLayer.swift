import Foundation
import Firebase

// Database
public var FirebaseRef: DatabaseReference!

protocol NetworkLayer {
    
    func configureFirebase ()
    //func configureFireBase () //finished: @escaping (Data) -> Void)
//    func loadFromServer(finished: @escaping (Data) -> Void)
}

class NetworkLayerImpl: NetworkLayer {
    
    func configureFirebase () {// finished: @escaping (Data) -> Void) {
        
        FirebaseApp.configure()
        FirebaseRef = Database.database().reference()
    }

    
    func loadFromServer(finished: @escaping (Data) -> Void) {
        print("loading data from server")
        
//        Alamofire.request("http://localhost:8080/tasks")
//            .responseJSON
//            { response in
//                guard let data = response.data else { return }
//                
//                finished(data)
//        }
    }
}
