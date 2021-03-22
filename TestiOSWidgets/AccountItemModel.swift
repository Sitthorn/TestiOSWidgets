//
//  AccountItem.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 24/2/2564 BE.
//

import Foundation
import iOSWidgets

class ResponseData: Codable {
    var status: StatusObject
}

struct StatusObject: Codable {
    var code: String?
    var message: String?
    var service: String?
//    var description: Description?
}

struct Description: Codable {
    var en: String?
    var th: String?
}

class AccountItemsResponse: ResponseData {
    var data: [AccountItemModel]?
    
    private enum CodingKeys: CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([AccountItemModel].self, forKey: .data)
        try super.init(from: decoder)
    }
}

class AccountItemModel: Codable {
    var productNameEng: String?
    var productNameTH: String?
    var productCode: String?
    var balanceCurrency: String?
    var currentBalance: String?
    var accountNumber: String?
    var relationshipCode: String?
    var accountStatusCode: String?
    var accountStatusText: String?
    var productGroupCode: String?
    var iconId: String?
    var iconFullURL: String?
    var sortOrder: String?
    var allowTransferFromAccount: String?
    var allowTransferOtherAccount: String?
    var transferOwnTMB: [String]?
    var transferOtherTMB: [String]?
    var personalizedAcctNicknameEn: String?
    var personalizedAcctNicknameTh: String?
    var accountName: String?
    var isRegisterPromptpay: String?
    var accountNumberDisplay: String?
    var allowTransferToPromptpay: String?
    var waiveFeeForPromptpay: String?
    var waiveFeeForPromptpayAccount: String?
}

struct DisplayAccountItems: CardDisplayItems, Equatable {
    
    var accountIconURL: URL?
    var accountIcon: String?
    var accountNumber: String?
    var accountName: String?
    var accountType: String?
    var amount: Double?
    var displayAmount: String?
    var checkFee: String?

    internal init(accountIconURL: URL? = nil, accountIcon: String? = nil, accountNumber: String? = nil, accountName: String? = nil, accountType: String? = nil, amount: Double? = nil, displayAmount: String? = nil, checkFee: String? = nil) {
        self.accountIconURL = accountIconURL
        self.accountIcon = accountIcon
        self.accountNumber = accountNumber
        self.accountName = accountName
        self.accountType = accountType
        self.amount = amount
        self.displayAmount = displayAmount
        self.checkFee = checkFee
    }
    
    init(with item: AccountItemModel?) {
        accountIcon = item?.iconId
        if let url = URL(string: item?.iconId ?? "") {
            accountIconURL = url
        }
        accountNumber = formatDisplayBankAccount(item?.accountNumberDisplay)
        accountName = item?.personalizedAcctNicknameTh
        displayAmount = formatAmountString(item?.currentBalance)
        amount = Double(item?.currentBalance ?? "")
        accountType = item?.accountName
    }
    
    static func == (lhs: DisplayAccountItems, rhs: DisplayAccountItems) -> Bool {
        return lhs.accountIconURL == rhs.accountIconURL &&
            lhs.accountIcon == rhs.accountIcon &&
            lhs.accountNumber == rhs.accountNumber &&
            lhs.accountName == rhs.accountName &&
            lhs.accountType == rhs.accountType &&
            lhs.amount == rhs.amount &&
            lhs.displayAmount == rhs.displayAmount &&
            lhs.checkFee == rhs.checkFee
    }
    
    private var formatter: NumberFormatter {
        let format = NumberFormatter()
        format.groupingSize = 3
        format.decimalSeparator = "."
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.groupingSeparator = ","
        format.usesGroupingSeparator = true
        return format
    }
    
    func formatDisplayBankAccount(_ account: String?) -> String {
        guard let account = account else {
            return ""
        }
        let pattern = "###-#-#####-#"
        let formatted = self.numberPatternCreater(input: account, pattern: pattern)
        return formatted
    }
    
    /// Format number with always have decimal 2 digits
    /// - Parameter amount: String of amount value
    /// - Returns: Formatted String of amount value
    func formatAmountString(_ amount: String?) -> String {
        guard let amount = amount else {
            return ""
        }
        
        let number = formatter.number(from: amount) ?? 0
        return formatter.string(from: number) ?? ""
    }
    
    func formatAmountNumber(_ amount: Double?) -> String {
        guard let amount = amount else {
            return ""
        }
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    func numberPatternCreater(input: String, pattern: String, separator: String.Element? = "-") -> String {
        guard let separatpr = separator else {
            return input
        }
        let groups = pattern.split(separator: separatpr).map { String($0) }
        let findingRegex = groups.map { "(\\d{\($0.count)})" }.joined(separator: "")
        let replacingRegex =  groups.enumerated().map { "$\($0.0 + 1)"}.joined(separator: String(separatpr))
        let result = input.replacingOccurrences(of: findingRegex,
                                                with: replacingRegex,
                                                options: .regularExpression,
                                                range: nil)
        return result
    }

}
