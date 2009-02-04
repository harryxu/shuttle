package cn.geckos.airuptests.controller {
	import cn.geckos.airuptests.view.UnitTestMediator;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class RunTestsCommand extends SimpleCommand implements ICommand {
		override public function execute(notification:INotification):void {
			
			// Register the UnitTestMediator.
			this.facade.registerMediator(new UnitTestMediator(notification.getBody() as AirupTest));
		}
	}
}