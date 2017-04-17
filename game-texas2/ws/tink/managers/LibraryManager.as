// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package ws.tink.managers
{
	import ws.tink.core.Library;
	import ws.tink.errors.*;
	public class LibraryManager
	{
		private var _libraries:Array;
		private static var _instance:ws.tink.managers.LibraryManager;
		private static var _allowConstructor:Boolean;
		public function LibraryManager()
		{
			if (!_allowConstructor){
				throw new LibraryManagerError(LibraryManagerError.FORCE_SINGLETON);
			}
			initialize();
		}
		public function contains(p__1:String):Boolean
		{
			return(!(getLibraryIndex(p__1) == -1));
		}
		public function getLibrary(p__1:String):ws.tink.core.Library
		{
			var l__2:int = getLibraryIndex(p__1);
			return((l__2 == -1) ? null : Library(_libraries[l__2]));
		}
		public function createLibrary(p__1:String):ws.tink.core.Library
		{			
			var l__2:ws.tink.core.Library;
			if (getLibraryIndex(p__1) == -1){
				l__2 = new Library(p__1);
				_libraries.push(l__2);
				return(l__2);
			}
			throw new LibraryManagerError(LibraryManagerError.DUPLICATE_LIBRARY_NAME);
			
		}
		public function addLibrary(p__1:ws.tink.core.Library, p__2:String):void
		{
			if (getLibraryIndex(p__2) == -1){
				_libraries.push(p__1);
			}
			throw new LibraryManagerError(LibraryManagerError.DUPLICATE_LIBRARY_NAME);
		}
		public function removeLibrary(p__1:String, p__2:Boolean = false):void
		{
			var l__4:ws.tink.core.Library;
			var l__3:int = getLibraryIndex(p__1);
			if (l__3 != -1){
				l__4 = Library(_libraries.splice(l__3, 1)[0]);
				if (p__2){
					l__4.destroy();
				}
			}
			throw new LibraryManagerError(LibraryManagerError.LIBRARY_NOT_FOUND);
		}
		private function initialize():void
		{
			_libraries = new Array();
		}
		private function getLibraryIndex(p__1:String):int
		{
			var l__2:int = _libraries.length;
			var l__3:int;
			while(l__3 < l__2){
				if ((p__1) == Library(_libraries[l__3]).name){
					return(l__3);
				}
				l__3++;
			}
			
			return(-1);
		}
		public static function get libraryManager():ws.tink.managers.LibraryManager
		{
			if (!_instance){
				_allowConstructor = true;
				_instance = new LibraryManager();
				_allowConstructor = false;
			}
			return(_instance);
		}
	}
}