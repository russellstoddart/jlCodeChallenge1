class TimeFormatter {

    func formatTime(_ seconds: Int) -> String {
        guard seconds != 0 else { return "none" }

        var secondsLeftToFormat = seconds
        var times = [String]()

        while secondsLeftToFormat != 0 {
            times.append(formatLargestUnit(in: &secondsLeftToFormat))
        }

        let timeString = addSeparators(times)
        return timeString
    }

    private func formatLargestUnit(in seconds: inout Int) -> String {
        switch seconds {
        case 31536000...:
            return formatYears(&seconds)
        case 86400...:
            return formatDays(&seconds)
        case 3600...:
            return formatHours(&seconds)
        case 60...:
            return formatMinutes(&seconds)
        case 0...:
            return formatSeconds(&seconds)
        default:
            fatalError()
        }
    }

    private func formatYears(_ seconds: inout Int) -> String {
        let numberOfYears = seconds / 31536000
        seconds = seconds - numberOfYears * 31536000
        let unit: String = numberOfYears == 1 ? "year" : "years"
        return "\(numberOfYears) \(unit)"
    }

    private func formatDays(_ seconds: inout Int) -> String {
        let numberOfDays = seconds / 86400
        seconds = seconds - numberOfDays * 86400
        let unit: String = numberOfDays == 1 ? "day" : "days"
        return "\(numberOfDays) \(unit)"
    }

    private func formatHours(_ seconds: inout Int) -> String {
        let numberOfHours = seconds / 3600
        seconds = seconds - numberOfHours * 3600
        let unit: String = numberOfHours == 1 ? "hour" : "hours"
        return "\(numberOfHours) \(unit)"
    }

    private func formatMinutes(_ seconds: inout Int) -> String {
        let numberOfMinutes = seconds / 60
        seconds = seconds - numberOfMinutes * 60
        let unit: String = numberOfMinutes == 1 ? "minute" : "minutes"
        return "\(numberOfMinutes) \(unit)"
    }

    private func formatSeconds(_ seconds: inout Int) -> String {
        let numberOfSeconds = seconds
        seconds -= seconds
        let unit: String = numberOfSeconds == 1 ? "second" : "seconds"
        return "\(numberOfSeconds) \(unit)"
    }

    private func addSeparators(_ times: [String]) -> String {
        let suffix = times.suffix(2)
        let joined = (times.dropLast(suffix.count) + [suffix.joined(separator: " and ")]).joined(separator: ", ")
        return joined
    }
}

import XCTest

class TimeFormatterTests: XCTestCase {

    func testFormatTime_returnsNone_for0() {
        let expected = "none"
        let result = TimeFormatter().formatTime(0)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Second_for1() {
        let expected = "1 second"
        let result = TimeFormatter().formatTime(1)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns2Seconds_for2() {
        let expected = "2 seconds"
        let result = TimeFormatter().formatTime(2)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Minute_for60() {
        let expected = "1 minute"
        let result = TimeFormatter().formatTime(60)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns2Minutes_for120() {
        let expected = "2 minutes"
        let result = TimeFormatter().formatTime(120)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1MinuteAndTwoSeconds_for62() {
        let expected = "1 minute and 2 seconds"
        let result = TimeFormatter().formatTime(62)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Hour_for3600() {
        let expected = "1 hour"
        let result = TimeFormatter().formatTime(3600)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns2Hours_for7200() {
        let expected = "2 hours"
        let result = TimeFormatter().formatTime(7200)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Hour1MinuteAnd1Second_for3661() {
        let expected = "1 hour, 1 minute and 1 second"
        let result = TimeFormatter().formatTime(3661)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1HourAnd1Minute_for3660() {
        let expected = "1 hour and 1 minute"
        let result = TimeFormatter().formatTime(3660)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1HourAnd1Second_for3601() {
        let expected = "1 hour and 1 second"
        let result = TimeFormatter().formatTime(3601)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Day_for86400() {
        let expected = "1 day"
        let result = TimeFormatter().formatTime(86400)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns2Days_for172800() {
        let expected = "2 days"
        let result = TimeFormatter().formatTime(172800)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Day1Hour1MinuteAnd1Second_for90061() {
        let expected = "1 day, 1 hour, 1 minute and 1 second"
        let result = TimeFormatter().formatTime(90061)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Day1HourAnd1Minute_for90060() {
        let expected = "1 day, 1 hour and 1 minute"
        let result = TimeFormatter().formatTime(90060)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1DayAnd1Hour_for90000() {
        let expected = "1 day and 1 hour"
        let result = TimeFormatter().formatTime(90000)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1DayAnd1Second_for86401() {
        let expected = "1 day and 1 second"
        let result = TimeFormatter().formatTime(86401)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Year_for31536000() {
        let expected = "1 year"
        let result = TimeFormatter().formatTime(31536000)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns2Years_for63072000() {
        let expected = "2 years"
        let result = TimeFormatter().formatTime(63072000)

        XCTAssertEqual(result, expected)
    }

    func testFormatTime_returns1Year1Day1Hour1Minute1Second_for31626061() {
        let expected = "1 year, 1 day, 1 hour, 1 minute and 1 second"
        let result = TimeFormatter().formatTime(31626061)

        XCTAssertEqual(result, expected)
    }
}

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)
TimeFormatterTests.defaultTestSuite.run()
