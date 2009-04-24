package cn.geckos.shuttle.controllers
{
import cn.geckos.shuttle.Notices;
import cn.geckos.shuttle.flickr.Developer;
import cn.geckos.shuttle.models.FlickrServiceProxy;
import cn.geckos.shuttle.views.ImageListMediator;
import cn.geckos.shuttle.views.MenuMediator;
import cn.geckos.shuttle.views.ProfileMediator;

import com.adobe.webapis.flickr.FlickrService;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class StartupCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        var app:Shuttle = notification.getBody() as Shuttle;
        
        // register mediators
        
        facade.registerMediator( new MenuMediator(MenuMediator.NAME, app) );
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
