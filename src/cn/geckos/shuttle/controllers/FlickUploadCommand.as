package cn.geckos.shuttle.controllers
{
import cn.geckos.shuttle.models.FlickrServiceProxy;
import cn.geckos.shuttle.models.vo.ImageVO;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class FlickUploadCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        FlickrServiceProxy(facade.retrieveProxy(FlickrServiceProxy.NAME))
            .upload( ImageVO(notification.getBody()) );
    }
        
}
}
