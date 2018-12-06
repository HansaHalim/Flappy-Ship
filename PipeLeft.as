package {

	import flash.display.MovieClip;


	public class PipeLeft extends MovieClip {


		public function PipeLeft(posX: int) {
			// constructor code
			this.x = 0 + posX;
		}
		public function moveVertically(): void {
			this.y += 20;
		}
		
		public function quitPipes(): void {
			this.y += 100000;
		}
	}

}