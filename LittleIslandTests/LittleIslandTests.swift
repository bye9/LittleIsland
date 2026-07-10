//
//  LittleIslandTests.swift
//  LittleIslandTests
//
//  Created by JeongHwan Seok on 7/10/26.
//

import Testing
@testable import LittleIsland

struct LittleIslandTests {
    @Test
    func 밤이면_sleeping() {
        #expect(MoodPolicy.policy(hour: 23) == .sleeping)
        #expect(MoodPolicy.policy(hour: 18) == .relaxing)
    }

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
