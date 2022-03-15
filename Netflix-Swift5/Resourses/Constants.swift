//
//  Constants.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import Foundation
import UIKit

struct Constants {
    static let API_KEY = "76356b96717e58e9d1bda0d70f93af9b"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube"
    static let youtube_API_KEY = "AIzaSyAYt3iYVv0fH16aA_y0GKjh9NLdTrH107g"
    
    static let sectionList: [SectionSettings] = [.myWallet, .myItem, .purchaseHistory, .dataUnionStatistic, .connectCeloWallet, .connectCreditCard, .help, .settings]
    
    enum SectionSettings {
        case myWallet
        case myItem
        case purchaseHistory
        case dataUnionStatistic
        case connectCeloWallet
        case connectCreditCard
        case help
        case settings
        
        var title: String {
            switch self {
            case .myWallet:
                return "My Wallet"
            case .myItem:
                return "My Item"
            case .purchaseHistory:
                return "Purchase History"
            case .dataUnionStatistic:
                return "Data Union Statistic"
            case .connectCeloWallet:
                return "Connect Celo Wallet"
            case .connectCreditCard:
                return "Connect Credit Card"
            case .help:
                return "Help"
            case .settings:
                return "Settings"
            }
        }
        
        var image: UIImage {
            switch self {
            case .myWallet:
                return UIImage(named: "Wallet")!
            case .myItem:
                return UIImage(named: "Item")!
            case .purchaseHistory:
                return UIImage(named: "Lines")!
            case .dataUnionStatistic:
                return UIImage(named: "Data")!
            case .connectCeloWallet:
                return UIImage(named: "Plus")!
            case .connectCreditCard:
                return UIImage(named: "Plus")!
            case .help:
                return UIImage(named: "Help")!
            case .settings:
                return UIImage(named: "Setting")!
            }
        }
    }
}
