package cn.geckos.airup.models
{
import cn.geckos.airup.Notices;

import com.adobe.webapis.flickr.AuthPerm;
import com.adobe.webapis.flickr.AuthResult;
import com.adobe.webapis.flickr.FlickrService;
import com.adobe.webapis.flickr.events.FlickrResultEvent;

import flash.data.EncryptedLocalStore;
import flash.utils.ByteArray;

import org.puremvc.as3.patterns.proxy.Proxy;

public class FlickrAuthProxy extends Proxy
{
    public static const NAME:String = 'FlickrAuthProxy';
    
    private var frob:String;
    
    protected function get service():FlickrService
    {
        return data as FlickrService;
    }
    
    public function FlickrAuthProxy(proxyName:String=null, data:Object=null)
    {
        super(proxyName, data);
        
        service.addEventListener(FlickrResultEvent.AUTH_GET_FROB, getFrobHandler, false, 0, true);
        service.addEventListener(FlickrResultEvent.AUTH_GET_TOKEN, getTokenHandler, false, 0, true);
        service.addEventListener(FlickrResultEvent.AUTH_CHECK_TOKEN, checkTokenltHandler, false, 0, true);
    }
	
	/**
	 * 
	 * @param id
	 * 
	 */
	public function auth(accountId:String):void
	{
	    var token:ByteArray = EncryptedLocalStore.getItem('flickr_' + accountId);
	    
	    if( token ) {
	        checkToken( token.readUTFBytes(token.length) );
	    }
	    else {
	        getFrob();
	    }
	}
	
	/**
	 * 获取 frob
	 * 
	 */
	public function getFrob(permission:String=AuthPerm.WRITE):void
	{
	    service.permission = permission;
	    service.auth.getFrob();
	    trace('getting flickr frob');
	}
	
	/**
	 * 
	 */
	private function getFrobHandler(event:FlickrResultEvent):void
	{
	    frob = event.data.frob;
	    
	    sendNotification(Notices.FLICKR_GOT_AUTH_FROB, {
	            'frob': frob,
	        'loginURL': service.getLoginURL(frob, service.permission)
	    });
	}
	
	/**
	 * 
	 * 
	 */
	public function getToken(frob:String=null):void
	{
	    if( !frob ) {
	        frob = this.frob;
	    }
	    service.auth.getToken(frob);
	}
	
	/**
	 * 
	 */
	private function getTokenHandler(event:FlickrResultEvent):void
	{
	    var result:AuthResult = AuthResult(event.data.auth);
	    
	    // 将 token 已本地加密存储
	    var bytes:ByteArray = new ByteArray();
	    bytes.writeUTFBytes(result.token);
	    EncryptedLocalStore.setItem('flickr_' + result.user.username, bytes);
	     
	    sendNotification(Notices.FLICKR_GOT_AUTH_TOKEN, result);
	}
	
	/**
	 * 检查  token 的响应权限等是否正确 
	 * 
	 */
	public function checkToken(token:String):void
	{
	    service.auth.checkToken(token);
	}
	
	private function checkTokenltHandler(event:FlickrResultEvent):void
	{
	    if( AuthResult(event.data.auth).perms == service.permission ) {
	        sendNotification(Notices.FLICKR_CHECK_TOKEN_OK);
	    }
	    else {
	        sendNotification(Notices.FLICKR_CHECK_TOKEN_FAILD);
	    }
	}
	
	
}
}