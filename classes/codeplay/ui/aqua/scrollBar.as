﻿// scrollBar class
// Version 0.9.0 2008-07-09
// (cc)2007-2008 codeplay
// By Jam Zhang
// jam@01media.cn

package codeplay.ui.aqua{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import codeplay.ui.aqua.scrollPanel;
	import codeplay.event.customEvent;

	public class scrollBar extends Sprite{

		public static const MINIMAL_HEIGHT:int=15;
		public static const MINIMAL_WIDTH:int=15;
		const DEFAULT_ALPHA:Number=.5;
		const ROLLOVER_ALPHA:Number=.75;

		var railLenght:int=300;
		var _barLength:int=50;
		var x0:int=x;
		var y0:int=y;

		public function scrollBar(data:Object=null):void{
			if(data!=null){
				if(data.x!=undefined)
					x=x0=data.x;
				if(data.y!=undefined)
					y=y0=data.y;
				if(data.x0!=undefined)
					x=x0=data.x0;
				if(data.y0!=undefined)
					y=y0=data.y0;
				if(data.railLenght!=undefined)
					railLenght=data.railLenght;
				if(data._barLength!=undefined)
					_barLength=data.barLength;
			}
			addEventListener(Event.ADDED_TO_STAGE,init);
		}

		function init(event:Event):void{
			alpha=DEFAULT_ALPHA;
			width=MINIMAL_WIDTH;
			height=_barLength;
			buttonMode=true;
			addEventListener(MouseEvent.MOUSE_DOWN,handleMouse);
			addEventListener(MouseEvent.MOUSE_OVER,handleMouse);
			addEventListener(MouseEvent.MOUSE_OUT,handleMouse);
			parent.addEventListener(customEvent.RESIZE,handleResize);
		}

		function handleResize(event:customEvent):void{
			var p:Number=percentage;
			switch(event.type){
				case customEvent.SCROLLBAR_RESIZED:
					railLenght=event.data.railLength;
					percentage=p;
					break;
				case customEvent.RESIZE:
					if(event.data!=null){
						railLenght=event.data.viewHeight;
						percentage=p;
					}
					break;
			}
		}

		function handleMouse(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.MOUSE_OVER:
					alpha=ROLLOVER_ALPHA;
					break;
				case MouseEvent.MOUSE_OUT:
					alpha=DEFAULT_ALPHA;
					break;
				case MouseEvent.MOUSE_DOWN:
					stage.addEventListener(MouseEvent.MOUSE_UP,handleMouse);
					stage.addEventListener(MouseEvent.MOUSE_MOVE,handleMouse);
					removeEventListener(MouseEvent.MOUSE_OUT,handleMouse);
					startDrag(false,new Rectangle(x0,y0,0,railLenght-_barLength));
					break;
				case MouseEvent.MOUSE_UP:
					parent.dispatchEvent(new customEvent(customEvent.SCROLLED,{percentage:percentage}));
					stage.removeEventListener(MouseEvent.MOUSE_UP,handleMouse);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE,handleMouse);
					addEventListener(MouseEvent.MOUSE_OUT,handleMouse);
					alpha=DEFAULT_ALPHA;
					stopDrag();
					break;
				case MouseEvent.MOUSE_MOVE:
					parent.dispatchEvent(new customEvent(customEvent.SCROLL,{percentage:percentage}));
					parent.dispatchEvent(new customEvent(customEvent.SCROLLING,{percentage:percentage}));
					break;
			}
		}

		function get percentage():Number{
			return (y-y0)/(railLenght-_barLength);
		}

		function set percentage(p:Number):void{
			y=y0+Math.round((railLenght-_barLength)*p);
		}

		function set barLength(l:int):void{
			height=_barLength=l;
		}

	}
}
