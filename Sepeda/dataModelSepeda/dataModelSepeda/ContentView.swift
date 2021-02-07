//
//  ContentView.swift
//  dataModelSepeda
//
//  Created by muhammad luthfi farizqi on 02/02/21.
//

import SwiftUI


struct ContentView: View {
    
    let data : [DataModel] = [
        DataModel(id: 1, namaProduk: "Polygon Xtrada", fotoProduk: "1", hargaProduk: 2000000, lokasi: "Kab. Karawang", ratingCount: 4, jumlahRating: 57),
        DataModel(id: 2, namaProduk: "Polygon Heist", fotoProduk: "2", hargaProduk: 3000000, lokasi: "Kab. Bogor", ratingCount: 5, jumlahRating: 50),
        DataModel(id: 3, namaProduk: "Polygon Monarch", fotoProduk: "3", hargaProduk: 5000000, lokasi: "Kab. Brebes", ratingCount: 4, jumlahRating: 56),
        DataModel(id: 4, namaProduk: "United Detroit", fotoProduk: "4", hargaProduk: 9000000, lokasi: "Kab. Pekalongan", ratingCount: 4, jumlahRating: 56),
        DataModel(id: 5, namaProduk: "United Miami", fotoProduk: "5", hargaProduk: 9000000, lokasi: "Kab. Pemalang", ratingCount: 3, jumlahRating: 56),
        DataModel(id: 6, namaProduk: "United Patrol", fotoProduk: "6", hargaProduk: 2000000, lokasi: "Kab. Bandung", ratingCount: 4, jumlahRating: 56),
        DataModel(id: 7, namaProduk: "Exotic M56 ", fotoProduk: "foto7", hargaProduk: 6000000, lokasi: "Kab. Garut", ratingCount: 5, jumlahRating: 56),
        DataModel(id: 8, namaProduk: "Exotic J98", fotoProduk: "7", hargaProduk: 2000000, lokasi: "Jakarta Selatan", ratingCount: 4, jumlahRating: 56),
        DataModel(id: 9, namaProduk: "Sepada lipat", fotoProduk: "8", hargaProduk: 8000000, lokasi: "Jakarta Barat", ratingCount: 3, jumlahRating: 56),
        DataModel(id: 10, namaProduk: "BMX", fotoProduk: "9", hargaProduk: 2000000, lokasi: "Jakarta Timur", ratingCount: 4, jumlahRating: 56)
    ]
    
    //    @State var jumlahkeranjang:Int = 1
    @ObservedObject var globaldata = GlobalObject()
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                ForEach(data) { row in // create number of rows
                    VStack(spacing:10){
                        Product(data: row, jumlahkeranjang: self.globaldata)
                    }
                    .padding()
                }
            }
                
            .navigationBarTitle("Sepeda MTB")
            .navigationBarItems(
                trailing:
                HStack(spacing:20){
                    statusView()
                    
                    NavigationLink(destination: DetailView(globaldata: globaldata)){
                        keranjangView(jumlahkeranjang: globaldata)
                    }
                    
                }
            )
        }
        .accentColor(Color.secondary)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct statusView : View {
    var body : some View {
        ZStack{
            
            Image(systemName: "person.fill")
            Text("")
                .foregroundColor(Color.white)
                .frame(width:5, height:5)
                .font(.body)
                .padding(5)
                .background(Color.green)
                .clipShape(Circle())
                .offset(x:10, y:-10)
        }
    }
}


struct keranjangView : View {
    //    @Binding var jumlah:Int
    @ObservedObject var jumlahkeranjang : GlobalObject
    
    var body : some View {
        ZStack{
            
            Image(systemName: "cart.fill")
            Text("\(self.jumlahkeranjang.jumlah)")
                .foregroundColor(Color.white)
                .frame(width:10, height:10)
                .font(.body)
                .padding(5)
                .background(Color.red)
                .clipShape(Circle())
                .offset(x:10, y:-10)
        }
    }
}

struct DetailView : View {
    @ObservedObject var globaldata : GlobalObject
    
    var body : some View {
        NavigationView {
            Text("Detail View")
                .navigationBarTitle("Detail")
                .navigationBarItems(
                    trailing:
                    HStack(spacing:20){
                        statusView()
                        //reusable view
                        keranjangView(jumlahkeranjang: globaldata)
                    }
            )
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Product : View {
    let data: DataModel
    @ObservedObject var jumlahkeranjang : GlobalObject
    
    var body: some View {
        
        VStack(alignment:.leading){
            ZStack(alignment:.topTrailing){
                
                
                Image(self.data.fotoProduk)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                
                Button(action: {print("heart clicked")}){
                    Image(systemName: "heart")
                        .padding()
                        .foregroundColor(Color.red)
                }
            }
            
            Text(self.data.namaProduk)
                .font(.title)
                .bold()
                .padding(.leading)
                .padding(.trailing)
            
            Text("Rp. \(self.data.hargaProduk)")
                .font(.title)
                .foregroundColor(.red)
                .bold()
                .padding(.leading)
                .padding(.trailing)
            
            HStack{
                Image(systemName: "mappin.circle")
                Text(self.data.lokasi)
            }
            .padding(.leading)
            .padding(.trailing)
            
            HStack {
                HStack{
                    ForEach(0..<self.data.ratingCount){
                        items in
                        Image(systemName: "star.fill")
                    }
                    
                    
                }.foregroundColor(.yellow)
                Text("\(self.data.jumlahRating)")
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            
            tambahKeranjang(data: data, keranjang: jumlahkeranjang)
            
        }
        .background(Color("warna"))
        .cornerRadius(15)
    }
}


struct tambahKeranjang : View {
    let data: DataModel
    //   @Binding var jumlah: Int
    @ObservedObject var keranjang : GlobalObject
    
    var body : some View {
        Button(action:{self.keranjang.jumlah += 1} ){
            HStack{
                Spacer()
                HStack{
                    Image(systemName: "cart")
                    Text("Tambah ke Keranjang")
                        .font(.callout)
                        .padding()
                }
                Spacer()
            }
        }
        .background(Color.green)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding()
    }
    
    
    
}
