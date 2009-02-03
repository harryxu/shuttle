package cn.geckos.airup.managers
{
import cn.geckos.airup.Version;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.xml.XMLNode;
import flash.xml.XMLNodeType;
    
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
        if( !getAccount(id, service) ) {
            var accountNode:XMLNode = new XMLNode(XMLNodeType.ELEMENT_NODE, 'account');
            
            var idNode:XMLNode = new XMLNode(XMLNodeType.ELEMENT_NODE, 'id'); 
            idNode.appendChild(new XMLNode(XMLNodeType.TEXT_NODE, id));
            
            var serviceNode:XMLNode = new XMLNode(XMLNodeType.ELEMENT_NODE, 'service');
            serviceNode.appendChild(new XMLNode(XMLNodeType.TEXT_NODE, service));
            
            accountNode.appendChild(idNode);
            accountNode.appendChild(serviceNode);
            
            getAccountsContent().appendChild( new XML(accountNode) );
            
            saveAccountsContent();
            
            return true;
        }
        
        return false;
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
        var account:XMLList = getAccountsContent().account.(id==id && service==service);
        if( account.toString() == '' ) {
            return null;
        }
        
        return XML(account[0]);
    }
    
    
    /**
     * 删除一个账户
     * @param id
     * @param service
     * @return 
     * 
     */
    // TODO
    public function deleteAccount(id:String, service:String='flickr'):Boolean
    {
        return false;
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
        if( !content ) {
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