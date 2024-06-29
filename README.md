# LazyWaterfallGrid

`LazyWaterfallGrid`是一个懒加载的瀑布流组件，可以用于显示大量数据。

## 示例代码

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
        LazyWaterfallGrid(items: items, column: $column, spacing: 6, complete: { width, item in
            return item.height  // return CGFloat.random(in: 100..<300)
          
        }, content: { item in
            Text("\(item.title)")
               
        }) 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
