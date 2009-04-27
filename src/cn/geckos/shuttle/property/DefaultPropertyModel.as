package cn.geckos.shuttle.property
{
public class DefaultPropertyModel implements IPropertyModel
{
    protected var propertyName:String;
    protected var owner:Object;
    
    public function DefaultPropertyModel(owner:Object, propertyName:String, value:*=null)
    {
        this.propertyName = propertyName;
        this.owner = owner;
        
        if( value ) {
            this.value = value;
        }
    }

    public function set value(value:*):void
    {
        owner[propertyName] = value;
    }
        
    public function get value():*
    {
        return owner[propertyName];
    }
        
}
}
