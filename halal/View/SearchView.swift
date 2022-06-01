//
//  SearchView.swift
//  halal
//
//  Created by Damir Akbarov on 26.04.2022.
//


import SwiftUI
import NukeUI

struct SearchView: View {
    
    @EnvironmentObject private var products: ProductsViewModel
    @State private var keyword = ""
    @AppStorage("lastRequests") private var lastRequests: [String] = []
    
    init(){
        Theme.navigationBarColors(background: UIColor(named: "color"), titleColor: UIColor(named: "titleColor"))
    }
    
    var body: some View {
        NavigationView {
            //        let keywordBinding = Binding<String>(
            //            get: {
            //                keyword
            //            },
            //            set: {
            //                keyword = $0
            //                products.fetchProducts(with: keyword)
            //            }
            //        )
            VStack {
                //SearchBarView(keyword: keywordBinding)
                ZStack{
                    if products.queryResultProducts.isEmpty && !keyword.isEmpty{
                        Text("No results").frame(maxWidth: .infinity, alignment: .center).font(.title)
                    }
                ScrollView {
                    ForEach(products.queryResultProducts) { product in
                        NavigationLink(destination: ProductView()){
                            ProductBarView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                            .simultaneousGesture(TapGesture().onEnded{
                                if let index = lastRequests.firstIndex(of: keyword) {
                                    lastRequests.remove(at: index)
                                }
                                else if lastRequests.count > 7{
                                    lastRequests.remove(at: 0)
                                }
                                lastRequests.append(keyword)
                                products.selectedProduct = product
                            })
                            .animation(.default, value: keyword)
                    }
                }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Поисковик")
            .navigationBarTitleDisplayMode(.inline)
        }.searchable(text: $keyword){
            if keyword.isEmpty{
                ForEach(lastRequests.reversed(), id: \.self) { request in
                    Text("\(request)").searchCompletion(request)
                }
                
            }
        }
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .onChange(of: keyword){ keyword in
            if !keyword.isEmpty{
                products.fetchProducts(with: keyword)
            }
            else{
                products.queryResultProducts.removeAll()
            }
            
        }
        .navigationViewStyle(.stack)
    }
}

//struct SearchBarView: View {
//    @Binding var keyword: String
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .foregroundColor(Color.gray.opacity(0.5))
//            HStack {
//                Image(systemName: "magnifyingglass")
//                    .renderingMode(.original)
//                TextField("Searching for...", text: $keyword)
//                .autocapitalization(.none)
//            }
//            .padding(.leading, 13)
//        }
//        .frame(height: 40)
//        .cornerRadius(13)
//        .padding()
//    }
//}

struct ProductBarView: View {
    
    fileprivate var product: Product
    
    var body: some View {
        ZStack {
            //Rectangle()
            //.foregroundColor(Color.gray.opacity(0.2))
            RoundedRectangle(cornerRadius: 13)
                .stroke(Color.gray, lineWidth: 1)
                .background(Color(UIColor(named: "productBarColor") ?? .clear))
            HStack {
                LazyImage(source: product.img, resizingMode: .aspectFit)
                    
                Text("\(product.name)")
                    .frame(minWidth: UIScreen.main.bounds.width/2, maxWidth: .infinity, alignment: .center)
                Spacer()
                switch product.halalStatus{
                case 1:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .dynamicTypeSize(.xxxLarge)
                        .imageScale(.large)
                case 2:
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.red)
                        .dynamicTypeSize(.xxxLarge)
                        .imageScale(.large)
                case 3:
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.black)
                        .dynamicTypeSize(.xxxLarge)
                        .imageScale(.large)
                default:
                    Text("--ERROR--")
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height/10)
        //        .overlay(
        //        RoundedRectangle(cornerRadius: 13)
        //                    .stroke(Color.gray, lineWidth: 1)
        //        )
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
