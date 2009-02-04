package cn.geckos.airuptests.model
{
import flexunit.framework.TestSuite;

public class FlickrServiceTestSuite extends TestSuite
{
    public function FlickrServiceTestSuite(param:Object=null)
    {
        super(param);
        
        addTestSuite(FlickrAuthProxyTest);
        
    }
        
}
}