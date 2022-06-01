//
//  HomeView.swift
//  halal
//
//  Created by Damir Akbarov on 26.04.2022.
//

import SwiftUI
import ACarousel
let roles = ["sushi", "aviata", "pizza"]

struct HomeView: View {
    @EnvironmentObject var categoriesViewModel: CategoriesViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("dr.halal").font(.custom("RobotoCondensed-Bold", size: 30)).foregroundColor(.green)
                    Text("Kazakhstan").font(.caption)
                }.frame(maxWidth: getRect().width-35, alignment: .leading)
                
                ACarousel(roles, id:  \.self, spacing: 15, isWrap: true ,autoScroll: .active(10)) { name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: getRect().width-55, height: getRect().height/5)
                        .cornerRadius(25)
                }
                .frame(height: getRect().height/5)
                Spacer()
                Text("Категории")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)

                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor(named: "homeColor") ?? .black))
                ZStack(alignment: .bottom){
                    CategoryListView(categories: categoriesViewModel.categories)
                    
                }.zIndex(-1)
                    .hiddenNavigationBarStyle()
            }.background(Color(UIColor(named: "homeColor") ?? .black))
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    VStack {
            //                        Text("dr.halal").font(.custom("RobotoCondensed-Bold", size: 30)).foregroundColor(.green)
            //                        Text("Kazakhstan").font(.caption)
            //                    }
            //                }
            //            }
        }.navigationViewStyle(.stack)
        
    }
}
struct CategoryListView: View{
    
    let categories: [Category]
    
    var body: some View {
        //        List(categories, id:\.id){ category in
        //            NavigationLink(destination:EmptyView()){
        //                Image(category.img)
        //                    .resizable()
        //                    .scaledToFit()
        //                    .frame(height: 70)
        //                    .cornerRadius(4)
        //                    .padding(.vertical,4)
        //                VStack(alignment: .leading, spacing: 5){
        //                    Text(category.name)
        //                        .fontWeight(.semibold)
        //                        .lineLimit(2)
        //                        .multilineTextAlignment(.center)
        //                        .minimumScaleFactor(0.5)
        //                        .frame(maxWidth: .infinity, alignment: .center)
        //                }
        //            }
        //        }
        List{
            
            Section{
                
                ForEach(categories, id:\.id){ category in
                    //if category.id == ""
                    NavigationLink(destination:EmptyView()){
                        Image(category.img)
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height/10)
                            .cornerRadius(4)
                            .padding(.vertical,4)
                        VStack(alignment: .leading, spacing: 5){
                            Text(category.name)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            }

        }.listStyle(.insetGrouped)
            .padding(.top, -35)
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CategoriesViewModel())
    }
}
