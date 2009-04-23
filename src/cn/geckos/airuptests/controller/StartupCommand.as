package cn.geckos.airuptests.controller {
	
	import cn.geckos.shuttle.flickr.Developer;
	import cn.geckos.shuttle.models.FlickrServiceProxy;
	
	import com.adobe.webapis.flickr.FlickrService;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand implements ICommand {
		public override function execute(notification:INotification):void {
			//var app:Example = notification.getBody() as Example;
			
			// Register all proxies
			
			var flickrService:FlickrService = new FlickrService(Developer.API_KEY);
			flickrService.secret = Developer.SECRET;
			
			facade.registerProxy(new FlickrServiceProxy(FlickrServiceProxy.NAME, flickrService));
			
			// Register all mediators
			//this.facade.registerMediator(new ApplicationMediator(app));
		}
	}
}
