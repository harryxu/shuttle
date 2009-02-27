package cn.geckos.airup.utils
{
public class SizeFormat
{
    public static var units:Array = ['B', 'KB', 'MB', 'GB'];
    
    /**
     * @param size
     * @param unit 0->byte, 1->KB, 2->MB, 3->GB  
     * @return 
     * 
     */
    public static function humanRead(size:Number, unit:uint=0):String
    {
        var numUnits:int = units.length;
        
        while( size >= 1024 && unit < numUnits )
        {
            if( unit == 0 ) {
	            size = Math.round(size / 1024);
            }
            else {
                size = Math.round(size/1024 * 100) / 100;
            }
            
            unit++;
        }
        
        return size + units[unit];
    }
}
}