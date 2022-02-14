//
//  ContentView.swift
//  Core Data Task
//
//  Created by Ilmari Lehmusjärvi on 7.2.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var itemTitle : String = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("My List")
                    .offset(x: -140)
                    .font(.title2)
                
                TextField(text: $itemTitle, prompt: Text("Create a new listing")) {
                    Text("Add Item")
                        .border(.secondary)
                        .offset(y: 100)
                    
                }
                .textFieldStyle(.roundedBorder)
                
                if (!itemTitle.self.isEmpty) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    
                }
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text(item.title ?? "error")
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            VStack{
                                Text(item.title ?? "error")
                                    .font(.title)
                                Text(item.timestamp!, formatter: itemFormatter)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = self.itemTitle
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
