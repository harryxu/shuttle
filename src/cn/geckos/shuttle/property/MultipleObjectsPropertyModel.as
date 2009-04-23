package cn.geckos.shuttle.property
{
    
/**
 * 为一系列对象设置统一属性的 Model
 */    
public class MultipleObjectsPropertyModel extends DefaultPropertyModeal
{
    protected var _value:*;
    
    public function MultipleObjectsPropertyModel(owner:Object, propertyName:String, value:*=null)
    {
        super(owner, propertyName, value);
    }

    override public function set value(value:*):void
    {
        if( _value != value ) {
            _value = value
            
	        for each( var obj:Object in owner )
	        {
	            obj[propertyName] = value;
	        }
        }
    }
        
    override public function get value():*
    {
        return _value;
    }
        
}
}
