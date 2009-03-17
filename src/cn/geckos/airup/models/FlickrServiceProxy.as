package cn.geckos.airup.models
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.flickr.getUploadRequest;
import cn.geckos.airup.models.vo.ImageVO;
import cn.geckos.crazyas.net.SequenceFileUploader;

import com.adobe.webapis.flickr.AuthPerm;
import com.adobe.webapis.flickr.AuthResult;
import com.adobe.webapis.flickr.FlickrService;
import com.adobe.webapis.flickr.events.FlickrResultEvent;

import flash.data.EncryptedLocalStore;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import org.puremvc.as3.patterns.proxy.Proxy;

public class FlickrServiceProxy extends Proxy
{
    public static const NAME:String = 'FlickrAuthProxy';
    
    private var frob:String;
    
    private var uploader:SequenceFileUploader;
    
    protected function get service():FlickrService
    {
        return data as FlickrService;
    }
    
    public function FlickrServiceProxy(proxyName:String, service:FlickrService)
    {
        super(proxyName, service);
        
        service.addEventListener(FlickrResultEvent.AUTH_GET_FROB, getFrobHandler, false, 0, true);
        service.addEventListener(FlickrResultEvent.AUTH_GET_TOKEN, getTokenHandler, false, 0, true);
        service.addEventListener(FlickrResultEvent.AUTH_CHECK_TOKEN, checkTokenltHandler, false, 0, true);
        service.addEventListener(FlickrResultEvent.PEOPLE_GET_INFO, getInfoHandler, false, 0, true);
        service.addEventListener(FlickrResultEvent.PEOPLE_GET_UPLOAD_STATUS, getUploadStatusHandler, false, 0, true);
    }
	
	/**
	 * 验证用户
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
	    
	    sendNotification(Notices.GET_FLICKR_AUTH_FROB_SUCCESS, {
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
	    service.token = result.token;
	    service.permission = result.perms;
	    
	    // 将 token 已本地加密存储
	    var bytes:ByteArray = new ByteArray();
	    bytes.writeUTFBytes(result.token);
	    EncryptedLocalStore.setItem('flickr_' + result.user.username, bytes);
	     
	    sendNotification(Notices.GET_FLICKR_AUTH_TOKEN_SUCCESS, result);
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
	    service.token = event.data.auth.token;
	    service.permission = event.data.auth.perms;
        sendNotification(Notices.CHECK_FLICKR_TOKEN_OK, event.data.auth);
	}
	
    /**
     * 获取用户信息
     * @param id
     * 
     */
    public function getUserInfo(id:String):void
    {
        service.people.getInfo(id);
    }
    
    private function getInfoHandler(event:FlickrResultEvent):void
    {
        sendNotification(Notices.GET_FLICKR_USER_INFO_SUCCESS, event.data.user);
    }
    
    /**
     * 获取上传状态（配额等。。）
     * 
     */
    public function getUploadStatus():void
    {
        service.people.getUploadStatus();
    }    
    
    public function getUploadStatusHandler(event:FlickrResultEvent):void
    {
        sendNotification(Notices.GET_QUOTA_SUCESS, event.data.user);
    }
    
    
    
    /**
     * 
     * @param imageVO
     * 
     */
    public function upload(vo:ImageVO):void
    {
        if( !uploader ) {
            uploader = new SequenceFileUploader();
        }
        
        var request:URLRequest = getUploadRequest(service, vo.file,
                                    vo.title,
                                    vo.description,
                                    vo.tags,
                                    vo.isPublic,
                                    vo.ifFriends,
                                    vo.isFamily,
                                    vo.safety,
                                    vo.content,
                                    vo.hidden);
        
        vo.wait();
        uploader.addFile(vo.file, request, 'photo');
        
        if( !uploader.running ) {
            uploader.start();
        }
    }
	
}
}