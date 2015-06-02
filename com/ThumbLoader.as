package com 
{
	/**
	 * ...
	 * @author zhangmc
	 */
	import com.TopBar;
	import fl.controls.Label;
	import fl.controls.ProgressBar;
	import fl.core.UIComponent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import fl.controls.ProgressBarMode;
	import fl.controls.ProgressBarDirection;
	
	public class ThumbLoader extends UIComponent
	{		
		private var loader:Loader = new Loader();        
		private var sw:Number;
		private var sh:Number;
		private var label:Label;
		private var topBar:TopBar = new TopBar();
		private var pb:ProgressBar;
		
		/**
		 * 构造函数
		 * @param    w  图片width
		 * @param    h  图片height
		 * @param    file  文件对象
		 */	
		public function ThumbLoader(w:Number,h:Number,file:FileReference) 
		{            
			this.sw = w;
			this.sh = h;
			this.width = w;
			this.height = h;
			
			label = new Label();
			label.width = w;
			label.move(0, 20);
			this.addChild(label);
			
			file.addEventListener(Event.COMPLETE, onComplete);
			file.addEventListener(IOErrorEvent.IO_ERROR, onError);
			file.load();
			

		
		} 
		
		/**
		 * 加载进度 监听器
		 * @param    e
		 */
		private function onLoadProgress(e:ProgressEvent):void
		{
			var num:uint = (e.bytesLoaded / e.bytesTotal) * 100;
			label.text = num.toString() + "%";
		}
		
		private function onError(e:IOErrorEvent):void
		{
			
		}
		
		/**
		 * 加载完成 监听器
		 * @param    e
		 */
		private function onComplete(e:Event):void
		{
			var file:FileReference = e.currentTarget as FileReference;
			loader.loadBytes(file.data);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
		}
		
		private function onLoadComplete(e:Event):void
		{
			var tempData:BitmapData=new BitmapData(loader.width,loader.height,
				false,0xff0000);
			tempData.draw(loader);
			var mat:Matrix = new Matrix();
			mat.scale(sw/loader.width, sh/loader.height);
			var bmd:BitmapData = new BitmapData(sw, sh, false, 0xffffff);
			bmd.draw(tempData, mat, null, null, null, true);
			var bitmap:Bitmap=new Bitmap(bmd);
			this.addChild(bitmap);
			//this.drawNow();
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,
				onLoadComplete);
				
			this.addChild(topBar);
			topBar.width = sw;
			topBar.x = 0;
			topBar.y = -topBar.height;
			/*
			pb = new ProgressBar();
			pb.mode = ProgressBarMode.MANUAL;
			pb.direction = ProgressBarDirection.RIGHT;
			pb.width = sw;
			pb.height = 30;
			pb.y = 40;
			this.addChild(pb);*/
			
			this.addEventListener(MouseEvent.MOUSE_OVER, thumOnMouserOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, thumOnMouserOut);

		} 
		
		private function thumOnMouserOver(event:MouseEvent):void {
			topBar.y = 0;
		}
		
		private function thumOnMouserOut(event:MouseEvent):void {
			topBar.y = -topBar.height;
		}
	}

}