package cn.geckos.airuptests {
	
	import cn.geckos.airuptests.controller.RunTestsCommand;
	import cn.geckos.airuptests.controller.StartupCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade implements IFacade {
		
		/****************************************
		 * NOTIFICATION NAMES
		****************************************/
		
		public static const STARTUP:String = "startup";
		public static const RUN_TESTS:String = "runTests";
		
		/**
		 * Gets the named ApplicationFacade instance.
		 */
		public static function getInstance():ApplicationFacade {
			if (instance == null) {
				instance = new ApplicationFacade();
			}
			
			return instance as ApplicationFacade;
		}
		
		/**
		 * Start the application.
		 */
		public function startup(app:AirupTest):void {
			sendNotification(STARTUP, app);
		}
		
		override protected function initializeController():void {
			super.initializeController();
			
			// Setup ApplicationFacade notifications
			registerCommand(STARTUP, StartupCommand);
			registerCommand(RUN_TESTS, RunTestsCommand);
		}
	}
}