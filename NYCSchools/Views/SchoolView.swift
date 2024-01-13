//
//  SchoolView.swift
//  NYCSchools
//
//  Created by Amos Todman on 1/12/24.
//

import Foundation
import SwiftUI

struct SchoolView: View {
    @ObservedObject var viewModel: ViewModel
    var school: School {
        viewModel.school
    }
    
    var body: some View {
        List {
            Section(header: Text(viewModel.locationText)) {
                VStack(alignment: .leading) {
                    Text("\(school.school_name ?? "")").font(.title2)
                    Text("\(school.city ?? ""), \(school.state_code ?? "") \(school.zip ?? "")")
                }
                
                if
                    let phoneNumber = school.phone_number,
                    let url = URL(string: "tel:\(phoneNumber)")
                {
                    VStack(alignment: .leading) {
                        Link(destination: url) {
                            Text("Phone: \(phoneNumber)")
                        }
                    }
                }
                
                if
                    let email = school.school_email,
                    let url = URL(string: "mailto:\(email)")
                {
                    VStack(alignment: .leading) {
                        Link(destination: url) {
                            Text("Email: \(email)")
                        }
                    }
                }
                
                if
                    let website = school.website,
                    let url = URL(string: "https://\(website)")
                {
                    VStack(alignment: .leading) {
                        Link(destination: url) {
                            Text("Web: \(website)")
                        }
                    }
                }
            }
            
            if let overviewParagraph = school.overview_paragraph {
                Section(header: Text(viewModel.overviewText)) {
                    VStack(alignment: .leading) {
                        Text(overviewParagraph)
                    }
                }
            }
            
            Section(header: Text(viewModel.avgScoresText)) {
                
                if
                    viewModel.hasSchoolDetails
                {
                    if let numTestTakers = viewModel.schoolDetails.num_of_sat_test_takers {
                        SchoolViewDataCell(title: viewModel.numOfSatTestTakers, description: numTestTakers)
                    }
                    if let criticalReadingAvgScore = viewModel.schoolDetails.sat_critical_reading_avg_score {
                        SchoolViewDataCell(title: viewModel.satCriticalReadingAvgScore, description: criticalReadingAvgScore)
                    }
                    
                    if let mathAvgScore = viewModel.schoolDetails.sat_math_avg_score {
                        SchoolViewDataCell(title: viewModel.satMathAvgScore, description: mathAvgScore)
                    }
                    if let writingAvgScore = viewModel.schoolDetails.sat_writing_avg_score {
                        SchoolViewDataCell(title: viewModel.satWritingAvgScore, description: writingAvgScore)
                    }
                        
                } else {
                    SchoolViewDataCell(title: viewModel.noDataText, description: "")
                }
            }
            
            if school.hasAcademicOpportunities {
                Section(header: Text(viewModel.academicOpportunitiesText)) {
                    if let academicopportunities1 = school.academicopportunities1 {
                        VStack(alignment: .leading) {
                            Text(academicopportunities1)
                        }
                    }
                    if let academicopportunities2 = school.academicopportunities2 {
                        VStack(alignment: .leading) {
                            Text(academicopportunities2)
                        }
                    }
                }
            }
            
            if let sports = school.school_sports {
                Section(header: Text(viewModel.sportsSectionText)) {
                    VStack(alignment: .leading) {
                        Text(sports)
                    }
                }
            }
            
            if school.hasRequirements {
                Section(header: Text(viewModel.requirementsSectionText)) {
                    if let requirement1 = school.requirement1_1 {
                        VStack(alignment: .leading) {
                            Text(requirement1)
                            
                        }
                    }
                    
                    if let requirement2 = school.requirement2_1 {
                        VStack(alignment: .leading) {
                            Text(requirement2)
                            
                        }
                    }
                    
                    if let requirement3 = school.requirement3_1 {
                        VStack(alignment: .leading) {
                            Text(requirement3)
                            
                        }
                    }
                    
                    if let requirement4 = school.requirement4_1 {
                        VStack(alignment: .leading) {
                            Text(requirement4)
                            
                        }
                    }
                    
                    if let requirement5 = school.requirement5_1 {
                        VStack(alignment: .leading) {
                            Text(requirement5)
                            
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .task {
            await viewModel.populateSchoolDetails()  
        }
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        
        let details = SchoolDetails.emptySchoolDetails
        SchoolView(viewModel: SchoolView.ViewModel(school: School.dummySchool, schoolDetails: details))
    }
}

extension SchoolView {
    struct SchoolViewDataCell: View {
        let title: String
        let description: String
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Text(description)
            }
        }
    }
}
