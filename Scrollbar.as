package
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle; 
	import flash.display.Shape; 

	public class Scrollbar extends MovieClip
	{
		
		private var minY:Number; 
		private var maxY:Number; 
		public var percentuale:uint; 
		private var contentstarty:Number; 
		public var bf:BlurFilter; 
		
		public function Scrollbar()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init); 
		}
		
		public function init(e:Event = null):void {
			
			reset();
			
			bf = new BlurFilter(0, 0, 1); 
			this.text.filters = new Array(bf); 
			this.text.mask = this.maskmc; 
			this.text.cacheAsBitmap = true; 
			
			this.minY = background.y; 
			this.maxY = background.y + background.height - ruler.height; 
			
			this.ruler.buttonMode = true; 

			this.contentstarty = text.y; 
			
			this.minY = 0; 
			this.maxY = this.background.height - this.ruler.height;

			ruler.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandle); 
			this.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandle, true); 
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandle); 
		}
		
		private function clickHandle(e:MouseEvent) 
		{
			var rect:Rectangle = new Rectangle(background.x-(ruler.width/2)+1, minY, 0, maxY);
			ruler.startDrag(false, rect);
		}
		
		private function releaseHandle(e:MouseEvent) 
		{
			ruler.stopDrag();
		}
		
		private function wheelHandle(e:MouseEvent)
		{
			if (this.area.hitTestPoint(stage.mouseX, stage.mouseY, false))
			{
			scrollData(e.delta);		
			}
		}
		
		private function enterFrameHandle(e:Event)
		{
			positionContent();
		}
		
		private function scrollData(q:int)
		{
			var d:Number;
			var rulerY:Number; 

			d = -q * 10; 
	
			if (d > 0) {
				rulerY = Math.min(maxY, ruler.y + d);
			}
			if (d < 0) {
				rulerY = Math.max(minY, ruler.y + d);
			}
			
			ruler.y = rulerY; 
	
			positionContent();
		}
		
		public function positionContent():void {
			var upY:Number;
			var downY:Number;
			var curY:Number;
	
			percentuale = (100 / maxY) * ruler.y;
				
			upY = 0;
			downY = text.height - (maskmc.height / 2) + 20;
			
			checkContentLength();
			 
			var fx:Number = contentstarty - (((downY - (maskmc.height/2)) / 100) * percentuale); 
			
			var curry:Number = text.y; 
			var finalx:Number = fx; 
			
			if (curry != finalx) {
				var diff:Number = finalx-curry;
				curry += diff / 4; 
				
				var bfactor:Number = Math.abs(diff)/8; 
				bf.blurY = bfactor/2; 
				text.filters = new Array(bf);
			}
			
			text.y = curry; 
			
		}
		
		public function checkContentLength():void
		{
			if (text.height < maskmc.height) {
				ruler.visible = false;
			} else {
				ruler.visible = true; 
			}
		}
		
		public function reset():void {
			text.y = 0; 
			ruler.y = 0; 			
		}
		
	}
}