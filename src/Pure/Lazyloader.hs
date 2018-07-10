{-# LANGUAGE OverloadedStrings #-}
module Pure.Lazyloader where

import Pure hiding (Visibility)
import Pure.Visibility
import Pure.Loader

import Data.Typeable

newtype Lazyloader key view response = Lazyloader { lazyloader :: Loader key view response }

instance (Eq key, Typeable key, Typeable view, Typeable response) => Pure (Lazyloader key view response) where
    view = 
        ComponentIO $ \self ->
            let
                load = modify_ self $ \_ _ -> True
            in
                def
                    { construct = return False
                    , Pure.render = \l onscreen -> 
                        if onscreen 
                          then View (lazyloader l)
                          else Visibility def <| OnOnScreen (Just $ const load) |> 
                                  [ Div <| Display "inline" . Height (pxs 1) . Width (pxs 1) ]
                    }