// TEAM C

import Foundation
import CareKitStore
import CareKit
import ParthenoKit

class StoreSynchronizer: OCKSynchronizedStoreManager
{
    var p = ParthenoKit()
    
    // Outcome update
    open override func outcomeStore(_ store: OCKAnyReadOnlyOutcomeStore, didAddOutcomes outcomes: [OCKAnyOutcome])
    {
        super.outcomeStore(store, didAddOutcomes: outcomes)
        readTasks();
    }
    
    func readTasks()
    {
        mystore.fetchTasks()
        { result in
            switch result
            {
                case .success(let tasks):
                    //print("------------- TASKS ----------")
                    //print(tasks)
                    
                    self.readOutcomes(tasks: tasks)
                    
               case .failure(let error):
                    print("Error  \(error)")
                    
            }
        }
    }//end read task
    
    func readOutcomes(tasks:[OCKTask]) -> String
    {
        var data:String = ""
        
        mystore.fetchOutcomes()
        { result in
            switch result
            {
                case .success(let outcomes):
                    //print("------------- OUTCOMES ----------")
                    //print(outcomes)
                    
                    for task in tasks
                    {
                        for outcome in outcomes
                        {
                            if outcome.belongs(to: task)
                            {
                                let d = outcome.createdDate!
                                let dateFormatterGet = DateFormatter()
                                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let t = task.title!
                                data = data + "\nMedics: \(t)\nDate & Time: \(dateFormatterGet.string(from: d))"
                            }
                        }
                    }
                    //SYNC HERE call parthenokit....
                    print("DATA \(data)")
                    let result = self.p.writeSync(team: "Team C", tag: "Dott Maniscalco", key: "Mario Rossi", value: data)
                    print (result)
                    
               case .failure(let error):
                    print("Error  \(error)")
            }
        }
    
        return data
    }
    
}
