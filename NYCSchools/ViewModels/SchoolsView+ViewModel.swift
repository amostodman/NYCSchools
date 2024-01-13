//
//  SchoolsView+ViewModel.swift
//  NYCSchools
//
//  Created by Amos Todman on 1/12/24.
//

import Foundation
import SwiftUI

extension SchoolsView {
    @MainActor
    class ViewModel: ObservableObject {
        var isForTesting: Bool = false
        let navigationTitle = "NYC Schools"
        @Published var schools = [School]()
        @Published var searchText = ""
        
        init(schools: [School] = [School](), searchText: String = "", isForTesting: Bool = false) {
            self.isForTesting = isForTesting
            self.schools = schools
            self.searchText = searchText
        }
        
        func populateSchools() async {
            if isForTesting {
                populateSchoolsFromJSONFile(filename: "Schools")
                return
            }
            
            do {
                let schools = try await WebService().get(url: Constants.Urls.schoolsUrl) { data in
                                    return try? JSONDecoder().decode([School].self, from: data)
                                }
                
                self.schools = schools.sorted {
                    $0.school_name  ?? "" < $1.school_name ?? ""
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        
        func populateSchoolsFromJSONFile(filename: String) {
            do {
                let schools = try WebService().loadJson(filename: filename) { data in
                                    return try? JSONDecoder().decode([School].self, from: data)
                                }
                self.schools = schools.sorted {
                    $0.school_name  ?? "" < $1.school_name ?? ""
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        
        var schoolsFiltered: [School] {
            if searchText.isEmpty {
                return schools
            } else {
                return schools.filter {
                    guard let schoolName = $0.school_name else {
                        return true
                    }
                    return schoolName.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
}
