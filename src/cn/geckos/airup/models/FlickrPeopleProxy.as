package cn.geckos.airup.models
{
import com.adobe.webapis.flickr.FlickrService;
import com.adobe.webapis.flickr.events.FlickrResultEvent;

import org.puremvc.as3.patterns.proxy.Proxy;

public class FlickrPeopleProxy extends Proxy
{
    public static const NAME:String = 'FlickrPeopleProxy';
    
    public function get service():FlickrService
    {
        return data as FlickrService;
    }
    
    public function FlickrPeopleProxy(proxyName:String, service:FlickrService)
    {
        super(proxyName, service);
        
        service.addEventListener(FlickrResultEvent.PEOPLE_GET_INFO, getInfoHandler, false, 0, true);
    }
    
    
    public function getUserInfo(id:String):void
    {
        service.people.getInfo(id);
    }
    
    private function getInfoHandler(event:FlickrResultEvent):void
    {
        
    }
    
}
}