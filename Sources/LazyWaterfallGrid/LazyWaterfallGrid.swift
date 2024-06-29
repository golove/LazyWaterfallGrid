// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

@available(iOS 14,*)
public struct LazyWaterfallGrid<Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
	var items: Data
	@Binding var column: Int
	var spacing: CGFloat
	var complete: (CGFloat, Data.Element) -> CGFloat // Provides the height of the element
	var content: (Data.Element) -> Content
	
	
	
	public init(items: Data, column: Binding<Int>, spacing: CGFloat = 6, complete: @escaping (CGFloat, Data.Element) -> CGFloat, content: @escaping (Data.Element) -> Content) {
		self.items = items
		self._column = column
		self.spacing = spacing
		self.complete = complete
		self.content = content
	}
	
	struct NewItem {
		var item: Data.Element
		var height: CGFloat
	}
	
	var newItems: [[NewItem]] {
		let width = UIScreen.main.bounds.width / CGFloat(column)
		var colsHeight = Array(repeating: CGFloat(0), count: column)
		var arr = Array(repeating: [NewItem](), count: column)
		
		for item in items {
			let itemHeight = complete(width, item)
			if let minIndex = colsHeight.firstIndex(of: colsHeight.min()!) {
				colsHeight[minIndex] += itemHeight
				arr[minIndex].append(NewItem(item: item, height: itemHeight))
			}
		}
		
		return arr
	}
	
	public var body: some View {
		HStack(alignment: .top, spacing: spacing) {
			ForEach(Array(newItems.enumerated()), id: \.offset) { index, items in
				LazyVStack(spacing: spacing) {
					ForEach(items, id: \.item.id) { newItem in
						content(newItem.item)
							.frame(height: newItem.height)
					}
				}
			}
		}
	}
}




struct Item: Identifiable {
   var id = UUID()
   var title: String
	var height:CGFloat
}

@available(iOS 18,*)
#Preview
{
	@Previewable @State	var column = 2
	
	let items: [Item] = [
		Item(title: "Item 1",height:160),
		Item(title: "Item 2",height:140),
		Item(title: "Item 3",height:80),
		Item(title: "Item 4",height:90),
		Item(title: "Item 5",height:180),
		Item(title: "Item 6",height:155),
		Item(title: "Item 7",height:130),
		Item(title: "Item 8",height:110),
		Item(title: "Item 9",height:190),
		Item(title: "Item 10",height:150),
		Item(title: "Item 11",height:120),
		Item(title: "Item 12",height:170),
		Item(title: "Item 13",height:180),
		Item(title: "Item 14",height:90),
		Item(title: "Item 15",height:160),
		Item(title: "Item 16",height:165),
		Item(title: "Item 17",height:130),
		Item(title: "Item 18",height:130),
		Item(title: "Item 19",height:190)
	   ]
	
		HStack{
			Button("Add Column"){
				withAnimation(.default){
					column += 1
					if column > 4 {
						column = 1
					}
				}
			}.buttonStyle(BorderedButtonStyle())
			Button("Minus Column"){
				withAnimation(.default){
					column -= 1
					if column<1{
						column = 4
					}
				}
			}.buttonStyle(BorderedButtonStyle())
		}
		ScrollView{
			LazyWaterfallGrid(items: items,column: $column,complete: {width,item in
				item.height
			} ,content: {e in
				ZStack{
					
					Rectangle()
						.fill( .pink )
					Text("\(e.title)")
						.foregroundStyle(.white)
				}
			})
		}
	
	
}

