//
//  ContentView.swift
//  Devote
//
//  Created by Sampel on 05/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK : - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task :String = ""
    @State private var  showNewTaskItem : Bool = false
    
    // FETCHING DATA
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
     //MARK- FUNCTION
    
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }


     //MARK-BODY
    var body: some View {
        NavigationView {
            // MARK : MAIN VIEW
            ZStack {
                // MARK : HEADER
                Spacer(minLength: 80)
                // MARK : NEW TASK BUTTON
                VStack {
                    //MARK: HEADER
                    HStack (spacing : 10 ) {
                        //  TITLE
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        // EDIT BUTTON
                        EditButton()
                            .font(.system(size : 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10 )
                            .frame(minWidth : 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        // APPEARANCE
                        
                        Button(action: {
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                            
                        }, label: {
                            Image (systemName: isDarkMode ? "moon.circle.fil" :   "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                    }
                    .padding()
                    .foregroundColor(.white)
                    Spacer()
                    
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        
                        Text("New task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 8, x: 0.0, y: 4.0)
               
                // MARK - TASKS
                    List {
                        ForEach(items) { item in
                           // NavigationLink {
                                ListRowItem(item: item )
                           // } label: {
                             //   Text(item.timestamp!, formatter: itemFormatter)
                            }
                            .onDelete(perform: deleteItems)
                        
                        
                    }
                    .listStyle( InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0 ),radius: 12)
                    
                    .padding(.vertical, 0)
                    .frame(maxWidth : 640)
                }  // : VSTACK
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration : 0.5 ))
                
                // MARK - NEW TASK ITEM
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor:isDarkMode ?  Color.black : Color.gray ,
                        backgroundOpacity:isDarkMode ? 0.3 : 0.5 )
                        .onTapGesture {
                            withAnimation(){
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
                    
            }// : ZSTACK
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarTitle("Daily Task", displayMode: .large)
            .navigationBarHidden(true)
            .background(
                    BackgroundImageView()
                        .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
            
            }
        .navigationViewStyle( StackNavigationViewStyle())
        }
    }
 //MARK-PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
