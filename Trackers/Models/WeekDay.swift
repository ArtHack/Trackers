import Foundation

enum WeekDay: String, CaseIterable {

    
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    
    var shortName: String {
        switch self {
        case .monday: return NSLocalizedString("Mo", comment: "")
        case .tuesday: return NSLocalizedString("Tu", comment: "")
        case .wednesday: return NSLocalizedString("We", comment: "")
        case .thursday: return NSLocalizedString("Th", comment: "")
        case .friday: return NSLocalizedString("Fr", comment: "")
        case .saturday: return NSLocalizedString("Sa", comment: "")
        case .sunday: return NSLocalizedString("Su", comment: "")
        }
        
        
    }
    
    var localizedName: String {
        switch self {
        case .monday: return NSLocalizedString("Monday", comment: "")
        case .tuesday: return NSLocalizedString("Tuesday", comment: "")
        case .wednesday: return NSLocalizedString("Wednesday", comment: "")
        case .thursday: return NSLocalizedString("Thursday", comment: "")
        case .friday: return NSLocalizedString("Friday", comment: "")
        case .saturday: return NSLocalizedString("Saturday", comment: "")
        case .sunday: return NSLocalizedString("Sunday", comment: "")
        }
    }
}

extension WeekDay {
    static func code(_ weekdays: [WeekDay]?) -> String? {
        guard let weekdays else { return nil }
        let indexes = weekdays.map { Self.allCases.firstIndex(of: $0) }
        var result = ""
        for i in 0..<7 {
            if indexes.contains(i) {
                result += "1"
            } else {
                result += "0"
            }
        }
        return result
    }
    
    static func decode(from string: String?) -> [WeekDay]? {
        guard let string else { return nil }
        var weekdays = [WeekDay]()
        for (index, value) in string.enumerated() {
            guard value == "1" else { continue }
            let weekday = Self.allCases[index]
            weekdays.append(weekday)
        }
        return weekdays
    }
}
