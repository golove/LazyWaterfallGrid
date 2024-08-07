# LazyWaterfallGrid

`LazyWaterfallGrid`是一个懒加载的瀑布流组件，可以用于显示大量数据。

<img width="319" alt="Screenshot 2024-06-29 at 17 58 52" src="https://github.com/golove/LazyWaterfallGrid/assets/61925349/a32a2de5-87bd-4aec-bd41-5afe8853705a">
<img width="339" alt="Screenshot 2024-06-29 at 17 58 15-1" src="https://github.com/golove/LazyWaterfallGrid/assets/61925349/c98188fd-8db4-47db-b913-97a8dbc06e90">
<img width="329" alt="Screenshot 2024-06-29 at 17 58 24" src="https://github.com/golove/LazyWaterfallGrid/assets/61925349/c139be5e-f667-4bb4-bcc3-a06ed3f37fa5">




## Installation
`LazyWaterfallGrid` is available through Swift Package Manager. To install it, simply add LazyWaterfallGrid to your Package.swift file and run swift package update.

`https://github.com/golove/LazyWaterfallGrid.git`



## Example

```swift
import SwiftUI
import LazyWaterfallGrid

struct Item: Identifiable {
   var id = UUID()
   var title: String
	var height:CGFloat
}

struct ContentView: View {

    let items: [Item] = [
		Item(title: "Item 1",height:160),
		Item(title: "Item 2",height:140),
		Item(title: "Item 3",height:80),
		Item(title: "Item 4",height:90),
		Item(title: "Item 5",height:180),
		Item(title: "Item 6",height:155),
		Item(title: "Item 7",height:130),
		Item(title: "Item 8",height:110),
		Item(title: "Item 9",height:190)
	   ]
    @State private	var column = 2
    var body: some View {
      	GeometryReader{porxy in
		// on macOS need divide scroll action tool width, example: let width = porxy.frame(in: .local).width - 14
		let width = porxy.frame(in: .local).width - 14
			ScrollView{
				LazyWaterfallGrid(mainWidth:width, items: items,column: $column,spacing: 6,complete: {width,item in
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```


