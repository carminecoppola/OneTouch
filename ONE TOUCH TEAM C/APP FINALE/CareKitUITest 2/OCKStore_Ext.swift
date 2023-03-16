// TEAM C

import Foundation
import CareKit
import CareKitStore

extension OCKStore {
    
    // Adds tasks and contacts into the store
    func populateDailyTasks() {
        
        let thisMorning = Calendar.current.startOfDay(for: Date())
        guard let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: thisMorning) else {
            return assertionFailure("Could not create time 8AM this morning")
        }
        //CARD
        
        //PRIMO
        let coughingSchedule2 = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1),
                               text: "Symptoms",
                               targetValues: [],
                               duration: .allDay)
        ])
        let test = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1),
                               text: "Capsule",
                               targetValues: [],
                               duration: .allDay)
        ])
        
        //SECONDO
        let coughingSchedule3 = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1),
                               text: "Symptoms",
                               targetValues: [],
                               duration: .allDay)
        ])
        let test3 = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1),
                               text: "Capsule",
                               targetValues: [],
                               duration: .allDay)
        ])
        
        //FINE CARD
        //PRIMA TASK
        var coughingTask2 = OCKTask(id: CareStoreReferenceManager.TaskIdentifiers.coughingEpisodes2.rawValue,
                                    title: "Back Pain",
                                    carePlanUUID: nil, schedule: coughingSchedule2)
        //FEBBRE
        var testTask = OCKTask(id: CareStoreReferenceManager.TaskIdentifiers.provaTask.rawValue,
                               title: "MAVENCLAD",
                               carePlanUUID: nil, schedule: test)
        
        //SECONDA TASK
        
        //FEBBRE
        var testTask3 = OCKTask(id: CareStoreReferenceManager.TaskIdentifiers.provaTask2.rawValue,
                                title: "TERIFLUNOMIDE",
                                carePlanUUID: nil, schedule: test3)
        
        var coughingTask3 = OCKTask(id: CareStoreReferenceManager.TaskIdentifiers.coughingEpisodes3.rawValue,
                                    title: "Dizziness",
                                    carePlanUUID: nil, schedule: coughingSchedule3)
        
        //FINE TASK
        
        coughingTask2.instructions = "Ho avuto un sintomo..."
        
        testTask.instructions = "Take it orally with a full glass of water or  with or without food."
        //SECONDO
        coughingTask3.instructions = "Ho avuto un malore..."
        
        testTask3.instructions = "Take orally without distinction from meals."
        
        //IMMAGINI
        testTask.asset = "Bugiardino2"
        testTask3.asset = "Bugiardino1"
        addTask(coughingTask2)
        addTask(testTask)
        
        addTask(coughingTask3)
        addTask(testTask3)
        
    }
}
