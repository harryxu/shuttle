package cn.geckos.airup.controllers
{
import cn.geckos.airup.models.FlickrServiceProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class GetFlickrUserInfoCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        var id:String = notification.getBody().toString();
        FlickrServiceProxy(facade.retrieveProxy(FlickrServiceProxy.NAME)).getUserInfo(id);
    }
}
}