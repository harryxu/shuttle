package cn.geckos.airup.property
{
    
/**
 * 为一系列对象设置统一属性的 Model
 */    
public class MultipleObjectsPropertyModel extends DefaultPropertyModeal
{
    protected var _value:*;
    
    public function MultipleObjectsPropertyModel(owner:Object, propertyName:String)
    {
        super(owner, propertyName);
    }

    override public function set value(value:*)
    {
        if( _value != value ) {
            _value = value
            
	        for each( var obj:Object in owner )
	        {
	            owner[propertyName] = value;
	        }
        }
    }
        
    override public function get value():*
    {
        return _value;
    }
        
}
}