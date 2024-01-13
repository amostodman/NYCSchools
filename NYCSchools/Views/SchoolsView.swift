//
//  SchoolsView.swift
//  NYCSchools
//
//  Created by Amos Todman on 1/12/24.
//

import Foundation
import SwiftUI

struct SchoolsView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.schoolsFiltered) { school in
                    NavigationLink(destination: SchoolView(viewModel: SchoolView.ViewModel(school: school, schoolDetails: SchoolDetails.emptySchoolDetails, isForTesting: viewModel.isForTesting))) {
                        HStack {
                            Text("\(school.school_name ?? "")")
                                .accessibilityIdentifier("schools.cell.\(school.id)")
                        }
                    }
                }
            }
            .navigationTitle(viewModel.navigationTitle)
            .searchable(text: $viewModel.searchText)
            .task {
                await viewModel.populateSchools()
            }
        }
    }
}

struct SchoolsView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolsView(viewModel: SchoolsView.ViewModel())
    }
}
