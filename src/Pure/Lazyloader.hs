{-# LANGUAGE OverloadedStrings #-}
module Pure.Lazyloader (module Pure.Lazyloader, module Pure.Loader) where

import Pure
import Pure.Intersection as I
import Pure.Loader

import Control.Monad (when)
import Data.List as List
import Data.Typeable

newtype Lazyloader key view response = Lazyloader { lazyloader :: Loader key view response }

instance (Eq key, Typeable key, Typeable view, Typeable response) => Pure (Lazyloader key view response) where
    view = 
        Component $ \self ->
            let
                load = modify_ self $ \_ _ -> True
            in
                def
                    { construct = return False
                    , Pure.render = \l onscreen -> 
                        if onscreen 
                          then View (lazyloader l)
                          else Observer def 
                                 <| I.Threshold [0] 
                                  . I.Action (\ts -> when (List.any I.intersecting ts) load)
                    }