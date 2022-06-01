//
//  ProductViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 27.04.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var queryResultProducts: [Product] = []
    @Published var selectedProduct: Product? = nil
    
    private let db = Firestore.firestore()

    func fetchData(){
        db.collection("product").addSnapshotListener { (query, error) in
            guard let documents = query?.documents else {
                print("No documents")
                return
            }
            self.products = documents.compactMap{(query) -> Product? in
                return try? query.data(as: Product.self)
            }
        }
    }
    func fetchProducts(with keyword: String){
        //queryResultProducts = products.filter{$0.keywordsForLookup.contains(where: { $0 == keyword })}
        queryResultProducts = products.filter({$0.keywordsForLookup.filter({$0.localizedCaseInsensitiveContains(keyword)}).count>0})
    }
}
