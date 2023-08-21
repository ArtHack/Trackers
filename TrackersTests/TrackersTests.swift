import XCTest
import SnapshotTesting
@testable import Trackers

final class TrackerAppTests: XCTestCase {
    
    func testTrackersViewControllerSnapshot() throws {
        let vc = TrackersViewController(trackerStore: StubTrackerStore())
        assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .light)))
    }
    
    func testTrackersViewControllerDarkSnapshot() throws {
        let vc = TrackersViewController(trackerStore: StubTrackerStore())
        assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .dark)))
    }
    
}


private class StubTrackerStore: TrackerStoreProtocol {
    var delegate: TrackerStoreDelegate?
    
    private static let category = TrackerCategory(title: "Фитнес")
    
    private static let trackers: [[Tracker]] = [
        [
            Tracker(
                id: UUID(),
                color: .trRed,
                text: "Разминка",
                emoji: "🙌",
                completedDaysCount: 10,
                schedule: [.saturday],
                isPinned: true,
                category: category
            )
        ],
        [
            Tracker(
                id: UUID(),
                color: .trBlue,
                text: "Плавание",
                emoji: "🏝️",
                completedDaysCount: 7,
                schedule: nil,
                isPinned: true,
                category: category
            ),
            Tracker(
                id: UUID(),
                color: .trRed,
                text: "Силовые",
                emoji: "😡",
                completedDaysCount: 1,
                schedule: nil,
                isPinned: false,
                category: category
            )
        ]
    ]
    
    var numberOfTrackers: Int = 3
    var numberOfSections: Int = 2
    
    func loadFilteredTrackers(date: Date, searchString: String) throws {}
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        default: return 0
        }
    }
    
    func headerLabelInSection(_ section: Int) -> String? {
        switch section {
        case 0: return "Закрепленные"
        case 1: return StubTrackerStore.category.title
        default: return nil
        }
    }
    
    func tracker(at indexPath: IndexPath) -> Tracker? {
        let tracker = StubTrackerStore.trackers[indexPath.section][indexPath.item]
        return tracker
    }
    
    func addTracker(_ tracker: Tracker, with category: TrackerCategory) throws {}
    func updateTracker(_ tracker: Tracker, with newData: Tracker) throws{}
    func deleteTracker(_ tracker: Tracker) throws {}
    func togglePin(for tracker: Tracker) throws {}
}
