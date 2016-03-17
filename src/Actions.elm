module Actions (..) where

import Artists.Actions
import Routing


type Action
  = NoOp
  | RoutingAction Routing.Action
  | ArtistsAction Artists.Actions.Action
  | ShowError String
