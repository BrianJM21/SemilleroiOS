# BitacorAPP
## Academia iOS - Second Team Project (using MVVM design)

### Team members:
## Brian Jiménez Moedano - Poject Manager
## David Eduardo Batista Trujillo - Developer 1
## Alan Badillo Salas - Developer 2

## Entities

>BitacorAPP - Mantained by Alan Badillo Salas
```swift
class BitacoraEntity {

    let id: Int64
    let title: String
    let details: String
    let latitude: Decimal
    let longitude: Decimal
    let createAt: Date
    let updateAt: Date
}

class BitacoraStatusEntity {

    let label: String
    let status: String
    let created: Date
    
    Relationship with BitacoraEntity (No Inverse)
}
```

##  Model

>BitacoraModel - Mantained by Alan Salas Badillo

```swift
import Foundation
import CoreData
import Combine

class BitacoraModel {
    
// COREDATA CONTAINER
    
    /// Container of model (to store objects to `CoreData`)
    lazy var container: NSPersistentContainer
    
    
    
    
    // MODEL STATES
    
    /// List of *bitácoras*
    @Published var bitacoras: [BitacoraEntity] = []
    
    /// List of *status of bitácoras*
    @Published var bitacoraStatus: [BitacoraStatusEntity] = []
    
    /// Current selected *bitácora* if exists
    @Published var bitacoraSelected: BitacoraEntity?
    
    /// List of *status* of current selected *bitácora* when is selected
    @Published var statusOfBitacoraSelected: [BitacoraStatusEntity] = []
    
    
    
    
    // MODEL OPERATIONS
    
    /// Loads list of *bitácoras* from the *CoreData*
    func loadBitacoras() {
    
    /// Loads list of *status of bitácoras* from the *CoreData*
    func loadStatusOfBitacoras() 
    
    /// Finds the *bitácora* by *id*, filter their *status of this bitácora*
    /// and finally assing it to the current selected *bitácora* and the
    /// current *status of bitácora* list
    func selectBitacora(byId id: Int)
    
    /// Creates a new *bitácora*
    func addBitacora(latitude lat: Decimal, longitude lon: Decimal) {
        
    /// Some attributes are set by default
    /// *NOTE:* current *bitácoras* is filtered to get max id, if *bitacoras*
    /// is empty, then set a default *id* of: 1
        bitacoraToAdd.id = bitacoraWithMaxId.id + 1    
        bitacoraToAdd.title = "Untitled"
        bitacoraToAdd.details = "No details"
        bitacoraToAdd.created = Date.now
        bitacoraToAdd.latitude = NSDecimalNumber(decimal: lat)
        bitacoraToAdd.longitude = NSDecimalNumber(decimal: lon)
        bitacoraToAdd.updated = nil
        
    }
    
    /// Updates the current selected *bitácora* either if title or details
    /// is filled
    func updateSelectedBitacora(title: String?, details: String?) 
    
    /// Creates a new *status* for the current *selected bitácora*
    func addStatusInSelectedBitacora(label: String, status: String)

```

##  Views

>BitacoraHomeView - Mantained by David Eduardo Batista Trujillo

```swift

import Foundation

// TODO: Documentanción definicion de los protocolos

protocol BitacoraHomeView: NSObject {
    
    func bitacora(bitacoras: [BitacoraEntity])
    
    func bitacora(bitacoraSelected: BitacoraEntity)
}

```

>BitacoraDetailsView - Mantained by Alan Badillo Salas

```swift

import Foundation

/// Protocol needed by view-controllers with data notifiers from view-models
protocol BitacoraDetailsView: NSObject {
    
    // FUNCTIONS WITH DATA NOTIFIERS FROM VIEW-MODEL
    
    /// Receive the current *selected bitácora* when it changes or made request
    func bitacora(bitacoraSelected bitacora: BitacoraEntity)
    
    /// Receive the list of *status* for the current *selected bitácora* when it changes or made request
    func bitacora(statusOfBitacoraSelected status: [BitacoraStatusEntity])
    
    /// Receive the current *selected bitácora* when it successfully updates
    func bitacora(bitacoraUpdated bitacora: BitacoraEntity)
    
}

```

## View-Models

>BitacoraHomeViewModel - Mantained by David Eduardo Batista Trujillo

```swift

import Foundation
import Combine

class BitacoraHomeViewModel {
   
    // MODEL AND VIEW BINDING
    
    weak var model: BitacoraModel?
    weak var view: BitacoraHomeView?

    // SUBSCRIBERS OF MODEL (WATCHERS/OBSERVABLES)
    
    var bitacorasSubscriber: AnyCancellable?
    var bitacoraSelectedSubscriber: AnyCancellable?
    
    // INITIALIZER
    
    /// Initialize new *View-Model* with the attached *model* to self and start
    /// listening to changes from the *model* with a subscriber sink method
    init(model: BitacoraModel)
        
    
    func addBitacora(latitude lat: Decimal, longitude lon: Decimal)
    
    
    func selectBitacora(byId id: Int) 
    
}

```

>BitacoraDetailsViewModel - Mantained by Alan Badillo Salas

```swift

import Foundation
import Combine

class BitacoraDetailsViewModel {
    
    // MODEL AND VIEW BINDING
    
    /// *Model* attached
    weak var model: BitacoraModel?
    
    /// *View* attached (associated view)
    weak var view: BitacoraDetailsView?
    
    // SUBSCRIBERS OF MODEL (WATCHERS/OBSERVABLES)
    
    /// Subscribe to the *model* `$bitacoraSelected` publisher
    var bitacoraSelectedSubscriber: AnyCancellable?
    
    /// Subscribe to the *model* `$statusOfBitacoraSelected` publisher
    var statusOfBitacoraSelectedSubscriber: AnyCancellable?
    
    /// Subscribe to the *model* `$bitacoras` publisher
    ///
    /// When we update the current *selected bitácora*
    /// all the *bitácoras* will be updated; themn,
    /// when we receive the *bitácoras* change notification
    /// we need to notify the view that the current *selected bitácora* was updated
    var bitacorasSubscriber: AnyCancellable?
    
    // INITIALIZER
    
    /// Initialize new *View-Model* with the attached *model* to *self*
    init(model: BitacoraModel)
    
    /// Listen changes from the *model* with a subscriber sink method
    func subscribeToModel() 
    
    /// Unsubscribe *model* subscribers
    func unsubscribeToModel() 
    
    /// Release the *model* and *view* if necessary
    func dispose()
    
    // OPERATIONS (FROM VIEW TO MODEL)
    
    /// Send the current *selected bitácora* to the *view*
    func refreshBitacoraSelected()
    
    /// Send the list of *status* of the current *selected bitácora* to the *view*
    func refreshStatusOfBitacoraSelected()
    
    func updateBitacora()
    
}

```
