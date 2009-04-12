package cn.geckos.airup.managers
{
import cn.geckos.airup.Version;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
    
public class AccountsManager
{
    
    private static var instance:AccountsManager;
    
    public static function getInstance():AccountsManager
    {
        if( !instance ) {
            instance = new AccountsManager();
        }
        
        return instance;
    }
    
    /**
     * 应用程序 Local Store 目录
     */
    private var localStore:File;
    
    /**
     * 账户配置文件
     */
    private var accountsFile:File;
    
    private var _accountContent:XML;
    
    /**
     * Constructor
     * 
     */
    public function AccountsManager()
    {
        localStore = File.applicationStorageDirectory;
        accountsFile = localStore.resolvePath('accounts.xml');
        
    }
    
    /**
     * 添加一个账户配置
     * 
     *  
     * @param id
     * @param service
     * 
     */
    // TODO 加一个 Account 类
    public function addAccount(id:String, service:String='flickr'):Boolean
    {
        if (!getAccount(id, service)) 
        {
            getAccountsContent().appendChild(
                new XML("<account id='"+id+"' service='"+service+"' />"));
            
            // 如果目前没有任何账户，就将此账户设成默认账户
            if(XMLList(getAccountsContent().account).length() == 1) 
            {
                setDefaultAccount(id, service, false);
            }
            
            // 保存到文件
            saveAccountsContent();
            
            return true;
        }
        
        return false;
    }
    
    /**
     * 设置默认的使用账户
     * @param id
     * @param service
     * @param save
     * 
     */
    public function setDefaultAccount(id:String, service:String, save:Boolean=true):void
    {
        if(getDefaultAccount())
        {
            delete getDefaultAccount().@isDefault;
        }
        
        var account:XML = getAccount(id, service);
        
        if (account)
        {
            account.@isDefault = 'true';
        }
        
        if (save)
        {
            saveAccountsContent();
        }
    }
    
    /**
     * 
     * @param id
     * @param service
     * @return 
     * 
     */
    public function getAccount(id:String, service:String='flickr'):XML
    {
        var account:XMLList = getAccountsContent().account.(@id==id && @service==service);
        if (!account || account.length() < 1) 
        {
            return null;
        }
        
        return XML(account[0]);
    }
    
    
    
    /**
     * 
     * @return 
     * 
     */
    public function getDefaultAccount():XML
    {
        var accounts:XMLList = getAccountsContent().account;
        
        if (accounts.length() < 1)
        {
            return null;
        }
        
        try
        {
            var account:XMLList = accounts.(@isDefault=='true');
        }
        catch (error:Error)
        {
            trace('no default account');
            return null;
        }
        
        if(!account || account.length() < 1 ) 
        {
            return null;
        }
        
        return account[0];
    }
    
    /**
     * 删除一个账户
     * @param id
     * @param service
     * @return 
     * 
     */
    public function deleteAccount(id:String, service:String='flickr'):Boolean
    {
        var content:XML = getAccountsContent();
        
        // 如果要删除的账户是默认账户，就删除默认账户
        if (id == getDefaultAccount().@id && service == getDefaultAccount().@service)
        {
            delete content.defaultAccount;
        }
        
        delete content.account.(@id==id && @service==service)[0];
        
        return saveAccountsContent();
    }
    
    /**
     * 
     * @return 
     * 
     */
    public function getAccountsContent():XML
    {
        if( !accountsFile.exists ) {
            createAccountsFile();
        }
        
        if( !_accountContent ) {
            var stream:FileStream = new FileStream();
            stream.open(accountsFile, FileMode.READ);
            var string:String = stream.readMultiByte(accountsFile.size, File.systemCharset);
            stream.close();
            
            _accountContent = new XML(string);
        }
        
        return _accountContent;
    }
    
    /**
     *  
     * @return 
     * 
     */
    public function saveAccountsContent():Boolean
    {
        return createAccountsFile(_accountContent);
    }
    
    /**
     * 初始化用户配置文件
     * 
     */
    private function createAccountsFile(content:XML=null):Boolean
    {
        if (!content) 
        {
	        content = 
	        <airup>
	            <version/>
	        </airup>;
	        content.version = Version.VER;
        }
        
        var stream:FileStream = new FileStream();
        stream.open(accountsFile, FileMode.WRITE);
        stream.writeMultiByte( content.toXMLString(), File.systemCharset );
        stream.close();
        
        return true;
    }

}
}