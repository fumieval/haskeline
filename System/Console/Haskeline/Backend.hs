module System.Console.Haskeline.Backend where

import System.Console.Haskeline.Term
import System.Console.Haskeline.Monads
import System.Console.Haskeline.InputT

#ifdef MINGW
import System.Console.Haskeline.Backend.Win32 as Win32
#else
import System.Console.Haskeline.Backend.Terminfo as Terminfo
import System.Console.Haskeline.Backend.DumbTerm as DumbTerm
#endif

myRunTerm :: MonadException m => IO (RunTerm (InputCmdT m))

#ifdef MINGW
myRunTerm = return win32Term
#else
myRunTerm = do
    mRun <- runTerminfoDraw
    case mRun of 
        Nothing -> return runDumbTerm
        Just run -> return run
#endif