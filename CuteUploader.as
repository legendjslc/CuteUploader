package  {
	
	import com.ImageFile;
	import fl.controls.Button;
	import fl.controls.Label;
	import fl.controls.LabelButton;
	import fl.controls.TileList;
	import fl.controls.ScrollBarDirection;
	import fl.data.DataProvider;
	import flash.display.MovieClip;
	import com.ThumbCellRender;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	
	
	public class CuteUploader extends MovieClip {
		
		private var thumList:TileList = new TileList();
		public var  fileRef:FileReferenceList = new FileReferenceList();
		
		public function CuteUploader() {
			// constructor code
			
			
			thumList.setSize(640, 240);
			thumList.move(10, 60);
			thumList.direction = ScrollBarDirection.VERTICAL;
			thumList.columnWidth = 100;
			thumList.columnCount = 5;
			thumList.rowHeight = 100;

			
			btnBrowse.addEventListener(MouseEvent.CLICK, btnBrowse_clickHandler);
			btnUpload.addEventListener(MouseEvent.CLICK, btnUpload_clickHandler);
			
		}
		
		private function btnBrowse_clickHandler(evt:MouseEvent):void {
			fileRef.addEventListener(Event.SELECT, selectHandler);
			fileRef.browse();			
		}
		
		private function btnUpload_clickHandler(evt:MouseEvent):void {
			/*for each( var file:FileReference in fileRef.fileList) {
				var request:URLRequest = new URLRequest("http://localhost:1280/Uploadhandler.ashx");
				file.upload(request);
			}*/
			for (var i:int = 0; i < thumList.dataProvider.length; i++) {
				var a:Object = thumList.getItemAt(i);
				var thum:ThumbCellRender = thumList.itemToCellRenderer(thumList.dataProvider.getItemAt(i)) as ThumbCellRender;
				trace(i);
				
				thum.UploadFile("http://localhost:1280/Uploadhandler.ashx");
			}
			
		}
		
		private function selectHandler(event:Event):void {
			var files:FileReferenceList = event.target as FileReferenceList;
			
			var dp:DataProvider = new DataProvider();
			
			for each( var file:FileReference in files.fileList) {
				dp.addItem({label:file.name, file:file});
			}
			
			thumList.dataProvider.addItems(dp);
			thumList.setStyle("cellRenderer", ThumbCellRender);
			thumList.setRendererStyle("imagePadding", 5);  
			this.addChild(thumList);
		}
		
	}
	
}
