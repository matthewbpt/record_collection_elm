module Actions (..) where

import Artists.Actions
import Albums.Actions
import Routing


type Action
  = NoOp
  | RoutingAction Routing.Action
  | ArtistsAction Artists.Actions.Action
  | AlbumsAction Albums.Actions.Action
  | ShowError String
