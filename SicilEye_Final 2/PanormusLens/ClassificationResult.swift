//
//  ClassificationResult.swift
//  PanormusLens
//
//  Created by Andrea Sanfilippo on 08/07/24.
//

import SwiftUI
import Combine

class ClassificationResult: ObservableObject {
    @Published var identifier: String = ""
    @Published var confidence: Float = 0.0
}
