//
//  HouseRobber1.swift
//  HouseRobber1
//
//  Created by Kundan Kumar on 11/02/26.
//

import SwiftUI

struct HouseRobber1View: View {
    @State private var houseAmounts: String = "1, 2, 3, 1"
    @State private var maxRobbed: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter house amounts (comma separated)", text: $houseAmounts)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Calculate Max Robbery") {
                // Convert string input to an array of integers
                let nums = houseAmounts.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
                maxRobbed = rob(nums)
            }

            Text("Maximum money robbed: \(maxRobbed)")
                .font(.headline)
        }
        .padding()
    }
}

func rob(_ nums: [Int]) -> Int {
        if nums.isEmpty { return 0 }
        var rob1 = 0 // Represents the max money robbed up to the previous-previous house
        var rob2 = 0 // Represents the max money robbed up to the previous house

        // [rob1, rob2, n, n+1, ...]
        for n in nums {
            // new_max is the maximum of:
            // 1. rob2 (not robbing current house, so taking the max from the previous house)
            // 2. n + rob1 (robbing current house, so taking its value plus the max from the house before the previous one)
            let temp = max(rob2, n + rob1)
            rob1 = rob2 // Update rob1 to the previous rob2
            rob2 = temp // Update rob2 to the new maximum calculated
        }
        return rob2
    }

#Preview {
    HouseRobber1View()
}
