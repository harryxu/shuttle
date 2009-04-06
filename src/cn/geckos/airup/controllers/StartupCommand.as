package cn.geckos.airup.controllers
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.flickr.Developer;
import cn.geckos.airup.models.FlickrServiceProxy;
import cn.geckos.airup.views.ImageListMediator;
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
        facade.registerMediator( new ImageListMediator(ImageListMediator.NAME, app.imageList) );
        
        // register commands
        facade.registerCommand(Notices.AUTH_DEFAULT_ACCOUNT, AuthDefaultAccountCommand);
        facade.registerCommand(Notices.ADD_ACCOUNT, AddAccountCommand);
        facade.registerCommand(Notices.DELETE_ACCOUNT, DeleteAccountCommand);
        
        // flickr commands
        facade.registerCommand(Notices.GET_FLICKR_AUTH_FROB, GetFlickrAuthFrobCommand);
        facade.registerCommand(Notices.GET_FLICKR_AUTH_TOKEN, GetFlickrAuthTokenCommand);
        facade.registerCommand(Notices.GET_FLICKR_USER_INFO, GetServiceAccountInfoCommand);
        facade.registerCommand(Notices.UPLOAD, FlickUploadCommand);
        
        // register proxies
        
        var flickrService:FlickrService = new FlickrService(Developer.API_KEY);
        flickrService.secret = Developer.SECRET;
        
        facade.registerProxy( new FlickrServiceProxy(FlickrServiceProxy.NAME, flickrService) );
        // 
        
        sendNotification(Notices.AUTH_DEFAULT_ACCOUNT);
        
    }
}
}