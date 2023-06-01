//
//  CategoriesList.swift
//  halal
//
//  Created by Damir Akbarov on 26.05.2023.
//

import SwiftUI

struct CategoryList: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.categories, id: \.id) { category in
                    HStack {
                        Image(category.img)
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height/10)
                            .cornerRadius(4)
                            .padding(.vertical, 4)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(category.name)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .onNavigation {
                        viewModel.open(category)
                    }
                }
            }

        }.listStyle(.insetGrouped)
            .padding(.top, -35)
    }
}
