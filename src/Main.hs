module Main where

import Idris.Core.TT
import Idris.AbsSyntax
import Idris.ElabDecls
import Idris.REPL

import IRTS.Compiler
import IRTS.CodegenCommon
import IRTS.CodegenCpp

import Data.List
import System.Environment
import System.Exit

data Opts = Opts { inputs :: [FilePath],
                   output :: FilePath }

showUsage = do putStrLn "Usage: idris-cpp <ibc-files> [-o <output-file>]"
               exitWith ExitSuccess

getOpts :: IO Opts
getOpts = do xs <- getArgs
             return $ process (Opts [] "a.out") xs
  where
    process opts ("-o":o:xs) = process (opts { output = o }) xs
    process opts (x:xs) = process (opts { inputs = x:inputs opts }) xs
    process opts [] = opts

cpp_main :: Opts -> Idris ()
cpp_main opts = do elabPrims
                   loadInputs (inputs opts) Nothing
                   mainProg <- elabMain
                   ir <- compile (Via "cpp") (output opts) mainProg
                   let ir' = if ".cpp" `isSuffixOf` outputFilename ||
                                ".cc"  `isSuffixOf` outputFilename
                             then ir {outputType=Raw} 
                             else ir
                   runIO $ codegenCpp ir'
                     where outputFilename = output opts

main :: IO ()
main = do opts <- getOpts
          if (null (inputs opts)) 
             then showUsage
             else runMain (cpp_main opts)

