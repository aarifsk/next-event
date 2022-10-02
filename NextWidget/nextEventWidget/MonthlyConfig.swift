//
//  MonthlyConfig.swift
//  nextEventWidgetExtension
//
//  Created by Aarif Shaikh on 2022/10/02.
//

import SwiftUI

struct MonthlyConfig {
    let backgroundColor: Color
    let emojiText: String
    let weekdayTextColor: Color
    let dayTextColor: Color
    
    static func determineConfig(from date: Date) -> MonthlyConfig {
        let monthInt = Calendar.current.component(.month, from: date)
        switch monthInt {
        case 1:
            return MonthlyConfig(backgroundColor: .palePink, emojiText: "❄️", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 2:
            return MonthlyConfig(backgroundColor: .paleYellow, emojiText: "👻", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
            
        case 3:
            return MonthlyConfig(backgroundColor: .palePink, emojiText: "⚽️", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 4:
            return MonthlyConfig(backgroundColor: .paleYellow, emojiText: "🎆", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 5:
            return MonthlyConfig(backgroundColor: .darkGreen, emojiText: "✈️", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 6:
            return MonthlyConfig(backgroundColor: .paleGreen, emojiText: "🎳", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
            
        case 7:
            return MonthlyConfig(backgroundColor: .paleBlue, emojiText: "🎮", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 8:
            return MonthlyConfig(backgroundColor: .skyBlue, emojiText: "🎃", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 9:
            return MonthlyConfig(backgroundColor: .paleOrange, emojiText: "🥷", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 10:
            return MonthlyConfig(backgroundColor: .darkOrange, emojiText: "🐟", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
            
        case 11:
            return MonthlyConfig(backgroundColor: .paleRed, emojiText: "🤖", weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        case 12:
            return MonthlyConfig(backgroundColor: .paleBrown, emojiText:"👽" , weekdayTextColor: .black.opacity(0.7), dayTextColor: .white.opacity(0.6))
        default:
            return MonthlyConfig(backgroundColor: .black, emojiText: "❌", weekdayTextColor: .black, dayTextColor: .white)
            
        }
    }
}
