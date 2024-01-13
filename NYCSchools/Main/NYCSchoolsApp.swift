//
//  NYCSchoolsApp.swift
//  NYCSchools
//
//  Created by Amos Todman on 1/12/24.
//

import SwiftUI

@main
struct NYCSchoolsApp: App {
    var body: some Scene {
        WindowGroup {
            SchoolsView(viewModel: SchoolsView.ViewModel(isForTesting: true))
        }
    }
}
