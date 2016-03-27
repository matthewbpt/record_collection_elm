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
          , filter =
              model.filter
              --, showErrorAddress = Signal.forwardTo actionsMailbox.address ShowError
              --, deleteConfirmationAddress = askDeleteConfirmationMailbox.address
          }

        ( updatedModel, fx ) =
          Artists.Update.update subAction updateModel
      in
        ( { model | artists = updatedModel.artists, filter = updatedModel.filter }, Effects.map ArtistsAction fx )

    ShowError message ->
      ( { model | errorMessage = message }, Effects.none )

    NoOp ->
      ( model, Effects.none )
