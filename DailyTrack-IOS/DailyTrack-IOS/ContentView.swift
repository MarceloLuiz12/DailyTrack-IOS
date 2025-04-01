//
//  ContentView.swift
//  DailyTrack-IOS
//
//  Created by Marcelo luiz Pinheiro on 01/04/25.
//
import SwiftUI
import ToDoKitKMP

struct ContentView: View {
    @State private var tasks: [TaskModel] = []
    @State private var errorMessage: String?
    init() {
        startKoin()
    }
    
    let getAllTaskUseCase = GetTaskIOSHelperUseCase()
    let addTaskUseCase = AddTaskIOSHelperUseCase()
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(tasks, id: \.id) { task in
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                            Text("Description: \(task.description)")
                                .font(.subheadline)
                            Text("Status: \(task.status)")
                                .font(.subheadline)
                            Text("Created at: \(task.createdAt)")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .onAppear {
                addTasks()
            }
        }
    }
    
    private func loadTasks() {
        getAllTaskUseCase.getAllTasks(
            success: { tasks in
                self.tasks = tasks
            },
            error: { error in
                self.errorMessage = error.message
            }
        )
    }
    
    func startKoin(){
        KoinHelperKt.doInitKoin()
    }
    
    private func addTasks() {
        let mockTask = Task_(
            id: 1,
            title: "Mock Task",
            description: "This is a mock task description",
            status: 0,
            createdAt: 2
        )
        addTaskUseCase.addTask(
            task: mockTask,
            success: { success in
                loadTasks()
        
            },
            error: { error in
                self.errorMessage = error.message
            }
        )
    }
}

#Preview {
    ContentView()
}
