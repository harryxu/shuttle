package cn.geckos.airup.controllers
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.flickr.Developer;
import cn.geckos.airup.models.FlickrServiceProxy;
import cn.geckos.airup.views.ProfileMediator;

import com.adobe.webapis.flickr.FlickrService;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class StartupCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        var app:Airup = notification.getBody() as Airup;
        
        // register mediators
        
        facade.registerMediator( new ProfileMediator(ProfileMediator.NAME, app.profileBox) );
        
        // register commands
        
        facade.registerCommand(Notices.AUTH_DEFAULT_ACCOUNT, AuthDefaultAccountCommand);
        facade.registerCommand(Notices.ADD_ACCOUNT, AddAccountCommand);
        facade.registerCommand(Notices.GET_FLICKR_AUTH_FROB, GetFlickrAuthFrobCommand);
        facade.registerCommand(Notices.GET_FLICKR_AUTH_TOKEN, GetFlickrAuthTokenCommand);
        facade.registerCommand(Notices.GET_FLICKR_USER_INFO, GetFlickrUserInfoCommand);
        
        // register proxies
        
        var flickrService:FlickrService = new FlickrService(Developer.API_KEY);
        flickrService.secret = Developer.SECRET;
        
        facade.registerProxy( new FlickrServiceProxy(FlickrServiceProxy.NAME, flickrService) );
        // 
        
        sendNotification(Notices.AUTH_DEFAULT_ACCOUNT);
        
    }
}
}