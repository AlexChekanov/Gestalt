import Foundation

typealias TasksAndSourceBlock = (DataSource, [TaskDTO])->Void

protocol ModelLayer {
    func loadData(resultsLoaded: @escaping TasksAndSourceBlock)
}

class ModelLayerImpl: ModelLayer {
    
    fileprivate var networkLayer: NetworkLayer
    fileprivate var dataLayer: DataLayer
    fileprivate var translationLayer: TranslationLayer
    
    init(networkLayer: NetworkLayer,
         dataLayer: DataLayer,
         translationLayer: TranslationLayer)
    {
        self.networkLayer = networkLayer
        self.dataLayer = dataLayer
        self.translationLayer = translationLayer
    }
    
    func loadData(resultsLoaded: @escaping TasksAndSourceBlock) {
        func mainWork() {
            
            loadFromDB(from: .local)
            
            networkLayer.loadFromServer { data in
                let dtos = self.translationLayer.createTaskDTOsFromJsonData(data)
                self.dataLayer.save(dtos: dtos, translationLayer: self.translationLayer) {
                    loadFromDB(from: .network)
                }
            }
        }
        
        func loadFromDB(from source: DataSource) {
            dataLayer.loadFromDB { tasks in
                let dtos = translationLayer.toTaskDTOs(from: tasks)
                resultsLoaded(source, dtos)
            }
        }
        
        mainWork()
    }
}
