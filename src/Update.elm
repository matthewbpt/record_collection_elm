module Update (..) where

import Effects exposing (Effects)
import Debug
import Models exposing (..)
import Actions exposing (..)
import Routing
import Artists.Update
import Mailboxes exposing (..)


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case (Debug.log "action" action) of
    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update subAction model.routing
      in
        ( { model | routing = updatedRouting }, Effects.map RoutingAction fx )

    ArtistsAction subAction ->
      let
        updateModel =
          { artists =
              model.artists
              --, showErrorAddress = Signal.forwardTo actionsMailbox.address ShowError
              --, deleteConfirmationAddress = askDeleteConfirmationMailbox.address
          }

        ( updatedArtists, fx ) =
          Artists.Update.update subAction updateModel
      in
        ( { model | artists = updatedArtists }, Effects.map ArtistsAction fx )

    ShowError message ->
      ( { model | errorMessage = message }, Effects.none )

    NoOp ->
      ( model, Effects.none )
