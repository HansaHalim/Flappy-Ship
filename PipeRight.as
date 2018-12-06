package  {
	
	import flash.display.MovieClip;
	
	
	public class PipeRight extends MovieClip {
		
		
		public function PipeRight(posX:int) {
			// constructor code
			this.x = 1080 + posX ;
		}
		public function moveVertically2():void{
			this.y += 20;
		}
		public function quitPipes2(): void {
			this.y += 10000000;
		}
	
	}
}