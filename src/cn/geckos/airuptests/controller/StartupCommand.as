package cn.geckos.airuptests.controller {
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand implements ICommand {
		public override function execute(notification:INotification):void {
			//var app:Example = notification.getBody() as Example;
			
			// Register all proxies
			
			// Register all mediators
			//this.facade.registerMediator(new ApplicationMediator(app));
		}
	}
}