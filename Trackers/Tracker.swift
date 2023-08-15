import UIKit

struct Tracker {
    let id: UUID
    let text: String
    let emoji: String
    let color: UIColor
    var schedule: [WeekDay]
}
