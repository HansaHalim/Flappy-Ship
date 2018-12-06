package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.*;
	import flash.ui.*;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.media.*;
	import flash.net.*;


	public class Main extends MovieClip {
		public var pipesLeft: Array;
		public var pipesRight: Array;
		private var rocketShip:Rocket = new Rocket();
		private var restartButton:Restart = new Restart();
		private var gameOverText:GameOver = new GameOver();
		private var leftPressed: Boolean = false;
		private var rightPressed: Boolean = false;
		private var gameTimer: Timer = new Timer(1750, 0);
		private var scoreTimer: Timer = new Timer(1750, 0);
		private var scoreTimerDelayer:Timer = new Timer(1750, 1);
		private var score:int = 0;
		private var scoreText:TextField = new TextField();
		private var highScore: TextField = new TextField();
		private var highNum:int = 0;
		private var mySound:Sound = new Sound();
		private var myChannel:SoundChannel = new SoundChannel();
		private var endGameSong:Sound = new Sound();
		private var endGameChannel:SoundChannel = new SoundChannel();
		

		public function Main() {
			stage.stageWidth = 1090;
			stage.stageHeight = 1920;
			mySound.load(new URLRequest("openSong.mp3"));
			endGameSong.load(new URLRequest("endSong.mp3"));
			myChannel = mySound.play();
		}
		
		function startGame(): void {
			
			score = 0;
			
			rocketShip.rotation = 90;
			rocketShip.scaleX = 0.25;
			rocketShip.scaleY = 0.25;
			rocketShip.x = stage.stageWidth / 2;
			rocketShip.y = stage.stageHeight - 200;
			
			
			//Spawning an army of obstacle pipes
			pipesLeft = new Array();
			pipesRight = new Array();
			var newPipesLeft = new PipeLeft(0);
			var newPipesRight = new PipeRight(0);
			pipesLeft.push(newPipesLeft);
			pipesRight.push(newPipesRight);
			addChild(newPipesLeft);
			addChild(newPipesRight);

			//Obstacle Pipe Spawner Timer
			gameTimer.addEventListener(TimerEvent.TIMER, spawnNewPipes);
			gameTimer.start();
			stage.addEventListener(Event.ENTER_FRAME, movePipesVertically);
			
			//EventListeners for the Scoring System
			scoreTimerDelayer.addEventListener(TimerEvent.TIMER, delayTheTimer);
			scoreTimerDelayer.start();
			scoreTimer.addEventListener(TimerEvent.TIMER, makingScores);

			//Eventlisteners to control the direction of the Rocket Ship
			rocketShip.addEventListener(Event.ENTER_FRAME, moveInDirection);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		function delayTheTimer(event:TimerEvent):void{
			scoreTimer.start();
		}
		
		function makingScores(event:TimerEvent):void {
			score++;
			scoreText.text = "Score : " + score;
			scoreText.x = 300;
			scoreText.y = 340;
			scoreText.scaleX = 10;
			scoreText.scaleY = 10;
			scoreText.textColor = 0xFFFFFF;
			addChild(scoreText);
		}
		

		function spawnNewPipes(event: TimerEvent): void {
			var randomPosition: int = Math.floor(Math.random() * 901) - 300;

			var newPipesLeft: PipeLeft = new PipeLeft(randomPosition);
			pipesLeft.push(newPipesLeft);
			addChild(newPipesLeft);

			var newPipesRight: PipeRight = new PipeRight(randomPosition);
			pipesRight.push(newPipesRight);
			addChild(newPipesRight);
		}




		function movePipesVertically(event: Event): void {
			for each(var pipe: PipeLeft in pipesLeft) {
				pipe.moveVertically();
				if (rocketShip.hitTestObject(pipe)) {
					gameOver();
				}
			}
			for each(var pipe2: PipeRight in pipesRight) {
				pipe2.moveVertically2();
				if (rocketShip.hitTestObject(pipe2)) {
					gameOver();
				}
			}
		}

		
		function endThis(): void {
			for each(var pipe: PipeLeft in pipesLeft) {
				pipe.quitPipes();
			}
			for each(var pipe2: PipeRight in pipesRight) {
				pipe2.quitPipes2();
			}
		}
		
		
		function gameOver(): void {
			myChannel.stop();
			endGameChannel = endGameSong.play();
			if(score > highNum) {
				highNum = score;
			}
			//endSong.play;
			scoreTimer.stop()
			gameTimer.stop();
			highScore.text = "High Score : " + highNum;
			highScore.x = 170;
			highScore.y = 150;
			highScore.scaleX = 10;
			highScore.scaleY = 10;
			highScore.textColor = 0xFFFFFF;
			addChild(highScore);
			addChild(gameOverText);
			addChild(restartButton);
			endThis();
			restartButton.addEventListener(MouseEvent.CLICK, restartGame);
		}
				
		function restartGame(event:MouseEvent):void
		{
			endGameChannel.stop();
			myChannel = mySound.play();
			removeChild(gameOverText);
			removeChild(highScore);
			if(score > 0) {
				removeChild(scoreText);
			}
			removeChild(restartButton);
			stage.focus = this;
			startGame();
		}




		function moveInDirection(event: Event) {
			if (leftPressed) {
				rocketShip.x -= 30;
			}
			if (rightPressed) {
				rocketShip.x += 30;
			}
			addChild(rocketShip);
		}

		function keyPressed(event: KeyboardEvent): void {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					{
						leftPressed = true;
						break;
					}
				case Keyboard.RIGHT:
					{
						rightPressed = true;
						break;
					}
			}
		}

		function keyReleased(event: KeyboardEvent): void {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					{
						leftPressed = false;
						break;
					}
				case Keyboard.RIGHT:
					{
						rightPressed = false;
						break;
					}
			}
		}
	}

}

