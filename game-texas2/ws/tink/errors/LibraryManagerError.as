// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package ws.tink.errors
{
	public class LibraryManagerError extends Error
	{
		private const ERROR_MSG:Array = new Array("LibraryManager is to be used as a Singleton and should only be accessed through LibraryManager.libraryManager.", "There is already a library with this name. Libraries stored in the LibraryManager must be unique names.", "The supplied library name could not be found in the LibraryManager.");
		private const BASE_ERROR_CODE:uint = 3000;
		public static const LIBRARY_NOT_FOUND:uint = 1000;
		public static const DUPLICATE_LIBRARY_NAME:uint = 3002;
		public static const FORCE_SINGLETON:uint = 3001;
		public function LibraryManagerError(p__1:uint)
		{
			super(((("Error #" + p__1) + ": ") + ERROR_MSG[(p__1 - BASE_ERROR_CODE)]), p__1);
			name = "LibraryManagerError";
		}
	}
}