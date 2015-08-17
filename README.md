SQLiteDemo
===========

## What is this

If you want to lower the persistence level, for any reason, you can easily use the ```C``` based library ```libsqlite3``` in iOS. 

But, if you want to use ```Swift``` instead of ```Objective-C```, you may find some difficulties in importing the library or especially when dealing with the ```C``` pointers and structures inside ```Swift```.

Below, you can see how "beautiful" is the translation of a simple function of this library:

```Swift
func sqlite3_exec(_: COpaquePointer, 
                  sql: UnsafePointer<Int8>, 
                  callback: CFunctionPointer<((UnsafeMutablePointer<Void>, Int32, UnsafeMutablePointer<UnsafeMutablePointer<Int8>>, UnsafeMutablePointer<UnsafeMutablePointer<Int8>>) -> Int32)>, 
                  _: UnsafeMutablePointer<Void>, 
                  errmsg: UnsafeMutablePointer<UnsafeMutablePointer<Int8>>) -> Int32
```

This project is not a wrapper or something like that, it's only a very simple working example on how to effectively use the basic methods of ```libsqlite3```, like how to:
* Create and remove a database; 
* Create and remove tables;
* Insert, Update and Remove elements in a table;
* Select elements in a table;


## Author

Lucas Eduardo, lucasecf@gmail.com
