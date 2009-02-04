package cn.geckos.airuptests.view {
	import cn.geckos.airuptests.view.components.UnitTestForm;
	
	import flash.events.Event;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class UnitTestMediator extends Mediator implements IMediator {
		
		/**
		 * Mediator name
		 */
		public static const NAME:String = "UnitTestMediator";
		
		/**
		 * UsersUnitTestForm to render when this mediator is loaded.
		 */	
		private var _unitTestForm:UnitTestForm;
		
		/**
		 * Gets the main application view component.
		 */
		public function get app():AirupTest {
			return viewComponent as AirupTest;
		}
		
		/**
		 * Crate a new UnitTestMediator. Upon instantiation, the unit test
		 * form is displayed via modal dialog.
		 * 
		 * @param userModule View component for this mediator.
		 */
		public function UnitTestMediator(viewComponent:AirupTest = null) {
			super(NAME, viewComponent);
			
			_unitTestForm = new UnitTestForm();
			showTestForm();
		}
		
		/****************************************
		 * PRIVATE METHODS
		****************************************/
		
		private function showTestForm():void {
			//PopUpManager.addPopUp(_unitTestForm as IFlexDisplayObject, this.app, true);
			//PopUpManager.centerPopUp(_unitTestForm);
			app.addChild(_unitTestForm);
		}
		
	}
}