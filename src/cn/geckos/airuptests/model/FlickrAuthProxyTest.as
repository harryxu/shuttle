package cn.geckos.airuptests.model
{
import cn.geckos.shuttle.Notices;
import cn.geckos.shuttle.models.FlickrServiceProxy;
import cn.geckos.airuptests.ApplicationFacade;

import com.andculture.puremvcflexunittesting.PureMVCNotificationEvent;
import com.andculture.puremvcflexunittesting.PureMVCTestCase;

import org.puremvc.as3.core.View;

public class FlickrAuthProxyTest extends PureMVCTestCase
{
    public function get proxy():FlickrServiceProxy
    {
        return ApplicationFacade.getInstance().retrieveProxy(FlickrServiceProxy.NAME) as FlickrServiceProxy;
    }
    
    public function FlickrAuthProxyTest(methodName:String=null)
    {
        super(methodName);
    }
    
    /*
    public function testGetFrob():void
    {
        registerObserver(View.getInstance(), proxy, Notices.FLICKR_GOT_AUTH_FROB, _testGetFrob, 5000);
        proxy.getFrob();
    }
    //*/
    
    private function _testGetFrob(event:PureMVCNotificationEvent):void
    {
        var obj:Object = event.notification.getBody();
        trace(obj.frob);
        trace(obj.loginURL);
    }
    
    /*
    public function testGetToken():void
    {
        registerObserver(View.getInstance(), proxy, Notices.FLICKR_GOT_AUTH_TOKEN, _testGetToken, 5000);
        proxy.getToken('72157613350744196-4fd98c9b0beb2725-550877');
    }
    //*/
    
    private function _testGetToken(event:PureMVCNotificationEvent):void
    {
        trace(event.notification.getBody().token);
    }
    
        
}
}
