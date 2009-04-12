package cn.geckos.airup
{
public class Notices
{
    //
    // 本地账户
    //
    
    /**
     * 登录默认账户
     */
    public static const AUTH_DEFAULT_ACCOUNT:String = 'authDefaultAccount';
    
    /**
     * 没有默认账户
     */
    public static const NO_DEFAULT_ACCOUNT:String = 'noDefaultAccount';
    
    /**
     * 添加账户
     */
    public static const ADD_ACCOUNT:String =    'addAccount';
    
    /**
     * 删除一个本地帐户
     */
    public static const DELETE_ACCOUNT:String = 'delteAccout';
    
    
    /**
     * 调用 ServiceProxy.auth 之前通知。 
     */
    public static const BEFORE_AUTH:String = 'beforeAuth';
    //
    //  Abstract Request and Response Notices for web service.
    //
    
    /**
     * Quota infomation, space, upload quota ... 
     */    
    public static const GET_QUOTA:String        = 'getQuota';
    public static const GET_QUOTA_SUCESS:String = 'getQuotaSuccess';
    
    //
    //  Flickr 服务相关
    //
    
    // auth frob
    public static const GET_FLICKR_AUTH_FROB:String         = 'getFlickrAuthFrob';
    public static const GET_FLICKR_AUTH_FROB_SUCCESS:String = 'flickrGotAuthFrob';
    
    // auth token
    public static const GET_FLICKR_AUTH_TOKEN:String         = 'getFlickrAuthToken';
    public static const GET_FLICKR_AUTH_TOKEN_SUCCESS:String = 'flickrGotAuthToken';
    public static const CHECK_FLICKR_TOKEN_OK:String         = 'flickrCheckTokenOK';
    public static const CHECK_FLICKR_TOKEN_FAILD:String      = 'flickrCheckTokenFailed';
    
    // people
    public static const GET_FLICKR_USER_INFO:String     = 'getFlickrUserInfo';
    public static const GET_FLICKR_USER_INFO_SUCCESS:String = 'getFilckrUserInfoSuccess';
    
    // upload
    public static const UPLOAD:String = 'upload';

}
}