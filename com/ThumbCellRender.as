package com 
{
	import fl.controls.LabelButton;
	import fl.controls.listClasses.CellRenderer;
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.listClasses.ImageCell;
	import fl.controls.listClasses.ListData;
	import fl.controls.ProgressBar;
	import fl.core.UIComponent;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import com.ThumbLoader;
	import flash.net.URLRequest;
	import fl.controls.ProgressBarMode;
	/**
	 * ...
	 * @author zhangmc
	 */
	public class ThumbCellRender extends UIComponent implements ICellRenderer 
	{
		private var loader:ThumbLoader;
		private var _listData:ListData;		
		private var _data:Object;
		private var w:int = 100;
		private var h:int = 100;
		//private var label:String;
		private var _selected:Boolean = false;
		private var file:FileReference;
		private var pb:ProgressBar;
		private var padding:Number = 5;
		private var status:String = FileStatusEnum.unloaded;
		
		public function ThumbCellRender() 
		{
			super();

		}

        public function set listData(newListData:ListData):void {
            _listData = newListData;
        }


        public function get listData():ListData {
            return _listData;
        }
		
		public function setMouseState(state:String):void {
		
		}
		
		
		public function set data(newData:Object):void {
            _data = newData;
			file = this.data.file as FileReference;
			loader = new ThumbLoader(w - padding*2, h - padding*2, file);
			loader.move(padding, padding);
			this.addChild(loader);
			
			pb = new ProgressBar();
			pb.mode = ProgressBarMode.MANUAL;
			pb.width = w - padding * 2;
			pb.height = 12;
			pb.x = padding;
			pb.y = 40;
			
			pb.setProgress(1, 20);
			this.addChild(pb);
        }

        public function get data():Object {
            return _data;
        }
		
		public function set selected(s:Boolean):void {
            _selected = s;
        }

        public function get selected():Boolean {
            return _selected;
        }
		
		public function UploadFile(url:String):void {

			var request:URLRequest = new URLRequest(url);
			file.addEventListener(ProgressEvent.PROGRESS, onUploadProgress);
			file.upload(request);
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData);
			file.addEventListener(IOErrorEvent.IO_ERROR, OnUploadIoError);
		}
		
		//上传进度事件
		private function onUploadProgress(event:ProgressEvent):void {
			if(pb!=null){
				pb.setProgress(event.bytesLoaded, event.bytesTotal);
				trace(event.bytesLoaded);
			}
		}
		
		//上传完成事件
		private function onUploadCompleteData(event:DataEvent):void {
			try{
				this.removeChild(pb);
			}catch(err:Error){}
			trace("completed");
			status = FileStatusEnum.uploaded;
		}
		
		//上传IO错误事件
		private function OnUploadIoError(event:IOErrorEvent):void {
			trace("IO error");
		}
	}

}