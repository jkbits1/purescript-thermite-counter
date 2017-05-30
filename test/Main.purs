
module Test.Main (main) where

import Prelude
-- import Components.TaskList (initialTaskListState, taskList)
-- import Control.Monad.Eff (Eff)
-- import DOM (DOM) as DOM
-- import Thermite as T

-- -- | The main method creates the task list component, and renders it to the document body.
-- main :: Eff (dom :: DOM.DOM) Unit
-- main = T.defaultMain taskList initialTaskListState unit

import Thermite as T

-- import React as R
import React.DOM as R
import React.DOM.Props as RP
-- import ReactDOM as RDOM

data Action = Increment | Decrement

type State = { counter :: Int }

initialState :: State
initialState = { counter : 0 }

render :: T.Render State _ Action
render send _ state _ =
  [ R.p' [ R.text (show state.counter)
         , R.button [ RP.onClick \_ -> send Increment ]
                    [ R.text "Increment" ]
         , R.button [ RP.onClick \_ -> send Decrement ]
                    [ R.text "Decrement" ]
         ]
  ]

performAction :: T.PerformAction _ State _ Action
performAction Increment _ _ = void (T.cotransform (\state -> state { counter = state.counter + 1 }))
performAction Decrement _ _ = void (T.cotransform (\state -> state { counter = state.counter - 1 }))

spec :: T.Spec _ State _ Action
spec = T.simpleSpec performAction render

main = T.defaultMain spec initialState unit



-- from https://bodil.lol/pure-ui/#30
-- module Main where

-- import Prelude
-- import Control.Monad.Eff.Console (log)
-- import DOM (DOM)
-- import DOM.HTML (window)
-- import DOM.HTML.Types (htmlDocumentToParentNode)
-- import DOM.HTML.Window (document)
-- import DOM.Node.ParentNode (querySelector)
-- import DOM.Node.Types (elementToNode, Node)
-- import Data.Maybe (Maybe(Just, Nothing), maybe)
-- import Data.Nullable (toMaybe)
-- import Data.VirtualDOM (patch, text, prop, h)
-- import Data.VirtualDOM.DOM (api)

-- main = do
--   doc ← window >>= document >>=
--     htmlDocumentToParentNode >>> pure
--   target ← querySelector "#target" doc >>=
--     toMaybe >>> map elementToNode >>> pure
--   maybe (log "No div#target found!") view target
