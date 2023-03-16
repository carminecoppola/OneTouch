// TEAM C

import Foundation
import CareKit
import CareKitStore

// Singleton wrapper to hold a reference to OCKSynchronizedStoreManager and task identifiers

let mystore = OCKStore(name: "One Touch")
final class CareStoreReferenceManager {
    
    enum TaskIdentifiers: String, CaseIterable {
        
        //PRIMO FARMACO
        case coughingEpisodes2
        case provaTask
        
        //SECONDO FARMACO
        case coughingEpisodes3
        case provaTask2

    }
    
    
    static let shared = CareStoreReferenceManager()
    
    // Manages synchronization of a CoreData store
    lazy var synchronizedStoreManager: OCKSynchronizedStoreManager = {
        
        mystore.populateDailyTasks()
        
       //let manager = OCKSynchronizedStoreManager(wrapping: store)
        let manager = StoreSynchronizer(wrapping: mystore)
        
        return manager
    }()
    
    private init() {}
}
