//
//  Menu.swift
//  Little Lemon
//
//  Created by Danny on 14/02/2023.
//

import SwiftUI
import Foundation

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var searchText = ""
    @State var cat = ""
    @State var isProfile = false
    
    private func buildPredicate() -> NSPredicate {
        var searchPredicate = NSPredicate(value: true)
        var catPredicate = NSPredicate(value: true)
//        if searchText == "" {
//            return NSPredicate(value: true)
//        }
        if searchText != "" {
            searchPredicate = NSPredicate(format:  "title CONTAINS[cd] %@", searchText)
        }
        if cat != "" {
            catPredicate = NSPredicate(format: "category = %@", cat)
        }
        let compoundPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [searchPredicate, catPredicate])
//        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        return compoundPredicate
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "title", ascending:  true, selector: #selector(NSString .localizedCompare))]
    }

    
    func getMenuData() {
        PersistenceController.shared.clear()
        let menuUrlString: String = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuUrl: URL = URL(string: menuUrlString)!
        let request = URLRequest(url: menuUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let menuData = try? JSONDecoder().decode(MenuList.self, from: data)
                menuData!.menu.forEach {
                    let oneDish = Dish(context: viewContext)
                    oneDish.id = $0.id
                    oneDish.title = $0.title
                    oneDish.descrip = $0.description
                    oneDish.image = $0.image
                    oneDish.price = $0.price
                    oneDish.category = $0.category
                }
                try? viewContext.save()
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack {
            LittleLemonLogo()
            LittleLemonBlurb()
            NavigationView {
                VStack {
                    Text ( "ORDER FOR DELIVERY!" )
                        .fontWeight(.bold)
                        .font(.title2)
                    HStack {
                        Button( "Starters" ) {
                            cat = "starters"
                        }
                        .fontWeight(.bold)
                        .buttonStyle(.bordered)
                        .foregroundColor(Color("myColorGreen"))
                        Button( "Mains" ) {
                            cat = "mains"
                        }
                        .fontWeight(.bold)
                        .buttonStyle(.bordered)
                        .foregroundColor(Color("myColorGreen"))
                        Button( "Desserts" ) {
                            cat = "desserts"
                        }
                        .fontWeight(.bold)
                        .buttonStyle(.bordered)
                        .foregroundColor(Color("myColorGreen"))
                        Button( " Drinks" ) {
                            cat = "drinks"
                        }
                        .fontWeight(.bold)
                        .buttonStyle(.bordered)
                        .foregroundColor(Color("myColorGreen"))
                    }
                    FetchedObjects(
                        predicate:buildPredicate(),
                        sortDescriptors: buildSortDescriptors()
                    ) {
                        (dishes: [Dish]) in
                        List {
                            // Code for the list enumeration here
                            ForEach(dishes, id:\.self) { dish in
                                DisplayDish(dish).onTapGesture {
                                        //showAlert.toggle()
                                }
                            }
                        }
                        // add the search bar modifier here
                        .searchable(text: $searchText, prompt: "search...")
                    }
                }
                .frame(width: 380, height: 300)
            }
        }
        .onAppear() {
            getMenuData()
        }
    }
}

struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text( dish.title ?? "" ).padding(.top, 7)
                .fontWeight(.bold)
            HStack{
                Text( dish.descrip! )
                Spacer()
                AsyncImage(url: URL(string: dish.image!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)

            }
            .contentShape(Rectangle()) // keep this code
            (Text( "$" ) + Text ( dish.price ?? "" ) + Text(".00")).padding([.top, .bottom], 7)
        }}
}

struct MenuList: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable {
    let id: Int32
    let title: String
    let description: String
    let image: String
    let price: String
    let category: String
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
