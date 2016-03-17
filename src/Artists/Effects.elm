module Artists.Effects (..) where

import Effects exposing (Effects)
import Http
import Task
import Artists.Models exposing (Artist)
import Artists.Actions exposing (..)
import Json.Decode as Decode exposing ((:=))
import Json.Decode.Extra exposing ((|:))
import Json.Encode as Encode


fetchAll : Effects Action
fetchAll =
  Http.get artistCollectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map ArtistsFetched
    |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "/api/artists"


createUrl : String
createUrl =
  "/api/artist"



-- DECODERS


artistCollectionDecoder : Decode.Decoder (List Artist)
artistCollectionDecoder =
  Decode.list artistDecoder


artistDecoder : Decode.Decoder Artist
artistDecoder =
  Decode.succeed Artist
    |: ("id" := Decode.int)
    |: ("name" := Decode.string)
    |: ("bio" := Decode.string)
    |: ("sortName" := Decode.string)
    |: (Decode.maybe ("image-id" := Decode.int))


artistEncoded : Artist -> Encode.Value
artistEncoded artist =
  let
    list =
      [ ( "id", Encode.int artist.id )
      , ( "name", Encode.string artist.name )
      , ( "bio", Encode.string artist.bio )
      , ( "sortName", Encode.string artist.sortName )
      , ( "image-id", Encode.int (Maybe.withDefault 0 artist.imageId) )
      ]
  in
    list
      |> Encode.object


createArtist : Artist -> Effects Action
createArtist artist =
  let
    body =
      artistEncoded artist
        |> Encode.encode 0
        |> Http.string

    config =
      { verb = "POST"
      , headers =
          [ ( "Content-Type", "application/json" )
          ]
      , url = createUrl
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson artistDecoder
      |> Task.toResult
      |> Task.map CreateArtistDone
      |> Effects.task
