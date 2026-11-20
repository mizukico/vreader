// Purpose: Sort options for the library view.

/// Available sort orders for the library book list.
enum LibrarySortOrder: String, Sendable, CaseIterable, Identifiable {
    case title
    case addedAt
    case lastReadAt
    case totalReadingTime

    var id: String { rawValue }

    /// Human-readable label for display in sort picker.
    var label: String {
        switch self {
        case .title: return String(localized: "Title")
        case .addedAt: return String(localized: "Date Added")
        case .lastReadAt: return String(localized: "Last Read")
        case .totalReadingTime: return String(localized: "Reading Time")
        }
    }
}
