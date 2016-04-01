module Artists.Update (..) where

import Effects exposing (Effects)
import Artists.Actions exposing (..)
import Artists.Models exposing (..)
import Artists.Effects exposing (..)
import Hop
import Task


--import Artists.Effects exposing (..)


type alias UpdateModel =
  { artists : List Artist
  , filter : String
  }


update : Action -> UpdateModel -> ( UpdateModel, Effects Action )
update action model =
  case action of
    ListArtists ->
      let
        path =
          "/artists/"
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    ListAlbums ->
      let
        path =
          "/albums/"
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    CreateOrUpdateArtist artist ->
      let
        filteredArtists =
          List.filter (\a -> a.id /= artist.id) model.artists

        updatedArtists =
          artist :: filteredArtists

        fx =
          Task.succeed (EditArtist artist)
            |> Effects.task

        updatedModel =
          { model | artists = updatedArtists }
      in
        ( updatedModel, fx )

    SaveArtist artist ->
      ( model, createArtist artist )

    SaveArtistDone result ->
      case result of
        Ok artist ->
          let
            filteredArtists =
              List.filter (\a -> a.id /= artist.id) model.artists

            updatedArtists =
              artist :: filteredArtists

            fx =
              Task.succeed (EditArtist artist)
                |> Effects.task

            updatedModel =
              { model | artists = updatedArtists }
          in
            ( updatedModel, fx )

        Err error ->
          ( model, Effects.none )

    DeleteArtist artist ->
      ( model, deleteArtist artist )

    DeleteArtistDone result ->
      case result of
        Ok artist ->
          let
            newArtists =
              List.filter (\a -> a.id /= artist.id) model.artists

            updatedModel =
              { model | artists = newArtists }

            fx =
              Task.succeed (ListArtists)
                |> Effects.task
          in
            ( updatedModel, fx )

        Err error ->
          ( model, Effects.none )

    EditArtist artist ->
      let
        path =
          "/artist/" ++ artist.name ++ "/edit"
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    ShowArtist artist ->
      let
        path =
          "/artist/" ++ artist.name
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    ShowAlbum album ->
      let
        path =
          "/album/" ++ album.title
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    ArtistsFetched result ->
      case result of
        Ok artists ->
          ( { model | artists = artists }, Effects.none )

        Err _ ->
          ( model, Effects.none )

    FilterArtists filter ->
      ( { model | filter = filter }, Effects.none )

    HopAction _ ->
      ( model, Effects.none )

    NoOp ->
      ( model, Effects.none )
