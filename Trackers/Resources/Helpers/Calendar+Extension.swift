import Foundation

extension Calendar {
    static let mondayFirst: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.locale = Locale(identifier: "ru_RU")
        return calendar
    }()
}
