// TEAM C

import Foundation
import CareKit
import CareKitStore

final class SymptomTrackerViewController: OCKDailyPageViewController {
    
    override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController,
                                          prepare listViewController: OCKListViewController, for date: Date) {
        
        let identifiers = CareStoreReferenceManager.TaskIdentifiers.allCases.map { $0.rawValue }
        var query = OCKTaskQuery(for: date)
        query.ids = identifiers
        query.excludesTasksWithNoEvents = true
        
        storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { result in
            guard let tasks = try? result.get() else { return }
            
            tasks.forEach { task in
                switch task.id {
                
                
                //PRIMO CASO
                case CareStoreReferenceManager.TaskIdentifiers.provaTask.rawValue:
                    let coughingCard = OCKButtonLogTaskViewController(task: task,
                                                                      eventQuery: .init(for: date),
                                                                      storeManager: self.storeManager)
                    listViewController.appendViewController(coughingCard, animated: false)
                    
                    
                    let TeriTask = tasks[1]
                    let TeriCard = OCKSimpleTaskViewController(task: TeriTask, eventQuery: .init(for: date), storeManager: self.storeManager)
                    listViewController.appendViewController(TeriCard, animated: false)
                    
                //SECONDO CASO
                case CareStoreReferenceManager.TaskIdentifiers.provaTask2.rawValue:
                    let coughingCard2 = OCKButtonLogTaskViewController(task: task,
                                                                       eventQuery: .init(for: date),
                                                                       storeManager: self.storeManager)
                    listViewController.appendViewController(coughingCard2, animated: false)
                    
                    
                    let TeriTask2 = tasks[3]
                    let TeriCard2 = OCKSimpleTaskViewController(task: TeriTask2, eventQuery: .init(for: date), storeManager: self.storeManager)
                    listViewController.appendViewController(TeriCard2, animated: false)
                    
                    
                    
                    //GRAFICO
                    let testaDataSeries = OCKDataSeriesConfiguration(
                        taskID: CareStoreReferenceManager.TaskIdentifiers.provaTask.rawValue,
                        legendTitle: "Back Pain",
                        gradientStartColor: .systemOrange,
                        gradientEndColor: .systemOrange,
                        markerSize: 15,
                        eventAggregator: OCKEventAggregator.countOutcomeValues)
                    let sintomDataSeries = OCKDataSeriesConfiguration(
                        taskID: CareStoreReferenceManager.TaskIdentifiers.provaTask2.rawValue,
                        legendTitle: "Symptoms",
                        gradientStartColor: .systemGreen,
                        gradientEndColor: .systemGreen,
                        markerSize: 15,
                        eventAggregator: OCKEventAggregator.countOutcomeValues)
                    
                    let insightsCard = OCKCartesianChartViewController(
                        plotType: .bar,
                        selectedDate: date,
                        configurations: [testaDataSeries, sintomDataSeries],
                        storeManager: self.storeManager)
                    
                    insightsCard.chartView.headerView.titleLabel.text = "MAVENCLAD & TERIFLUNOMIDE"
                    insightsCard.chartView.headerView.detailLabel.text = "This Week"
                    insightsCard.chartView.headerView.accessibilityLabel = "MAVENCLAD & Teriflunomide, This Week"
                    listViewController.appendViewController(insightsCard, animated: false)
                    
                    
                default: return
                }
            }
        }
    }
    
}
