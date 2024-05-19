{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_data_analysis (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/monk/.cabal/bin"
libdir     = "/home/monk/.cabal/lib/x86_64-linux-ghc-8.8.4/data-analysis-0.1.0.0-inplace-data-analysis"
dynlibdir  = "/home/monk/.cabal/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/home/monk/.cabal/share/x86_64-linux-ghc-8.8.4/data-analysis-0.1.0.0"
libexecdir = "/home/monk/.cabal/libexec/x86_64-linux-ghc-8.8.4/data-analysis-0.1.0.0"
sysconfdir = "/home/monk/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "data_analysis_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "data_analysis_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "data_analysis_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "data_analysis_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "data_analysis_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "data_analysis_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
