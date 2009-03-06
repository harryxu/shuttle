package cn.geckos.airup.property
{
    
/**
 * 为一系列对象设置统一属性的 Model
 */    
public class ObjectsListPropertyModel extends DefaultPropertyModeal
{
    private var _value:*;
    
    public function ObjectsListPropertyModel(owner:Object, propertyName:String)
    {
        super(owner, propertyName);
    }

    public function set value(value:*)
    {
        if( _value != value ) {
            _value = value
            
	        for each( var obj:Object in owner )
	        {
	            owner[propertyName] = value;
	        }
        }
    }
        
    public function get value():*
    {
        return _value;
    }
        
}
}