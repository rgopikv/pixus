﻿// pixusOverlay class// The class controlling the overlay//// (cc)2007-2009 JPEG Interactive// By Jam Zhang// jammind@gmail.compackage {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	public class pixusOverlay extends Sprite {		public function pixusOverlay():void {			visible=false;		}		public function move(x1:int,y1:int):void {			themask.inner.x=x1;			themask.inner.y=y1;		}		public function get overlayWidth() {			return themask.inner.width-1;		}		public function get overlayHeight() {			return themask.inner.height-1;		}		public function set overlayWidth(w:uint) {			themask.inner.width=w+1;		}		public function set overlayHeight(h:uint) {			themask.inner.height=h+1;		}	}}