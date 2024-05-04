//
//  ContentView.swift
//  TestApp
//
//  Created by 홍승표 on 4/30/24.
//

import SwiftUI
import SwiftData

// ContentView: SwiftUI의 View 프로토콜을 준수하는 구조체로, 앱의 기본 화면을 정의합니다.
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext // SwiftData의 modelContext를 사용하여 데이터를 관리합니다.
    @Query private var items: [Item] // Item 모델의 배열을 나타내는 속성으로, SwiftData의 @Query 속성 래퍼를 사용하여 데이터를 쿼리합니다.

    var body: some View {
        // NavigationSplitView를 사용하여 메인 뷰와 디테일 뷰를 구분하고, List를 사용하여 아이템 목록을 표시합니다.
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        // 아이템을 선택하면 디테일 뷰로 이동하도록 합니다.
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems) // 아이템을 삭제할 수 있도록 onDelete 핸들러를 추가합니다.
            }
            // 네비게이션 컬럼의 최소 및 이상적인 너비를 설정합니다.
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            // 툴바에 "Add Item" 버튼을 추가하여 아이템을 추가할 수 있도록 합니다.
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item") // 디테일 뷰에는 "Select an item" 텍스트를 표시합니다.
        }
    }

    // 아이템을 추가하는 메서드로, modelContext.insert()를 사용하여 새로운 아이템을 데이터에 추가합니다.
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    // 아이템을 삭제하는 메서드로, modelContext.delete()를 사용하여 선택한 아이템을 데이터에서 삭제합니다.
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

// ContentView의 미리보기를 생성합니다.
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
