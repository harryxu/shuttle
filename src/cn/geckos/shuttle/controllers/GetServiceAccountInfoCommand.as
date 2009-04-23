package cn.geckos.shuttle.controllers
{
import cn.geckos.shuttle.models.FlickrServiceProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class GetServiceAccountInfoCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        var id:String = notification.getBody().toString();
        var proxy:FlickrServiceProxy = 
            FlickrServiceProxy(facade.retrieveProxy(FlickrServiceProxy.NAME))
            
        proxy.getUserInfo(id);
        proxy.getUploadStatus();
    }
}
}
