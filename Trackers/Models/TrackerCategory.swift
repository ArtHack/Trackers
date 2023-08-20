import Foundation

import Foundation

struct TrackerCategory: Equatable {
    let id: UUID
    let title: String
    
    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}
