//
//  ProductView.swift
//  halal
//
//  Created by Damir Akbarov on 01.05.2022.
//

import SwiftUI
import NukeUI

struct ProductView: View {
    
    @EnvironmentObject private var products: ProductsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            TopPartDetailView()
                .padding(.horizontal)
                .zIndex(0)
            HeaderDetailView()
                .padding(.horizontal)
                .zIndex(1)
            
            // DETAIL BOTTOM PART
            VStack(alignment: .center, spacing: 0, content:{
                // DESCRIPTION
                ScrollView(.vertical, showsIndicators: false, content:{
                    Text(products.selectedProduct?.description ?? "bruh")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }) //: SCROLL
                Spacer()
            })
            .padding(.horizontal)
            .background(
                Color.white
                    .clipShape(CustomShape())
                    .padding(.top, -105)
            )
        })
        .zIndex(0)
        .ignoresSafeArea(.all, edges: .all)
        .background(Color(UIColor.secondarySystemBackground))
    }
}
struct HeaderDetailView: View{
    // MARK:-PROPERTY
    @EnvironmentObject private var products: ProductsViewModel
    
    // MARK:-BODY
    var body: some View{
        VStack(alignment: .leading, spacing: 6, content:{
            Text(products.selectedProduct?.name ?? "Bruh")
                .font(.title)
                .fontWeight(.black)
        }) //: VSTACK
        .foregroundColor(.black)
        .padding(.top, 5)
        //.padding()
    }
}

struct TopPartDetailView: View{
    // MARK:-PROPERTY
    @State private var isAnimating: Bool = false
    @EnvironmentObject private var products: ProductsViewModel
    // MARK:-BODY
    
    var body: some View {
        HStack(alignment: .center, spacing: 6, content: {
            // Halal
//            VStack(alignment: .leading, spacing: 6, content:{
//                Text("3")
//                    .font(.largeTitle)
//                    .fontWeight(.black)
//                    .scaleEffect(1.35, anchor: .leading)
//            })
//            .offset(y: isAnimating ? -50 : -75)
            
            Spacer()
            // PHOTO
            LazyImage(source: products.selectedProduct?.img ?? "https://media.istockphoto.com/vectors/error-with-glitch-effect-on-screen-error-404-page-not-found-flat-vector-id1142986365?k=20&m=1142986365&s=612x612&w=0&h=SKUaFfOTS3UsR1bg9PwSgnTYflbhM8GKycRTqjPlIWI=", resizingMode: .aspectFit)
                .scaledToFit()
                .offset(y: isAnimating ? 0: -35)
        }) //: HSTACK
        .onAppear(perform: {
            withAnimation(.easeOut(duration: 0.75)){
                isAnimating.toggle()
            }
        })
    }
}
struct CustomShape: Shape{
    func path(in rect: CGRect) -> Path{
        let path=UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}
//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView()
//    }
//}
