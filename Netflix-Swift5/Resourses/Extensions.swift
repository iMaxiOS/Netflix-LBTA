//
//  Extensions.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 10.03.2022.
//

import Foundation

extension String {
    func capitalizeFirstLatter() -> String {
        return self.prefix(1).uppercased() + self.dropFirst().lowercased()
    }
}
