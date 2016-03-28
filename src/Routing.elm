module Routing (..) where

import Effects exposing (Effects, Never)
import Hop


{-
Routing Actions

HopAction : is called after Hop has changed the location, we usually don't care about this action
ShowPlayers : Action that instructs to show the players page
ShowPlayerEdit : Action to show the Edit player page
ShowNotFound : Action that triggers when the browser location doesn't match any of our routes
NavigateTo : Action to change the browser location
-}


type Action
  = HopAction Hop.Action
  | ShowArtists Hop.Payload
  | ShowNotFound Hop.Payload
  | ShowArtistEdit Hop.Payload
  | ShowArtist Hop.Payload
  | NavigateTo String
  | NoOp



{-
Available views in our application
NotFoundView is necessary when no route matches the location
-}


type AvailableViews
  = ArtistsView
  | ArtistView
  | ArtistEditView
  | NotFoundView



{-
We need to store the payload given by Hop
And we store the current view
-}


type alias Model =
  { routerPayload : Hop.Payload
  , view : AvailableViews
  }


initialModel : Model
initialModel =
  { routerPayload = router.payload
  , view = ArtistsView
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    {-
    NavigateTo
    Called from our application views e.g. by clicking on a button
    asks Hop to change the page location
    -}
    NavigateTo path ->
      ( model, Effects.map HopAction (Hop.navigateTo path) )

    {-
    ShowPlayers and ShowPlayerEdit
    Actions called after a location change happens
    these are triggered by Hop
    -}
    ShowArtists payload ->
      ( { model | view = ArtistsView, routerPayload = payload }, Effects.none )

    ShowNotFound payload ->
      ( { model | view = NotFoundView, routerPayload = payload }, Effects.none )

    ShowArtistEdit payload ->
      ( { model | view = ArtistEditView, routerPayload = payload }, Effects.none )

    ShowArtist payload ->
      ( { model | view = ArtistView, routerPayload = payload }, Effects.none )

    _ ->
      ( model, Effects.none )



{-
Routes in our application
Each route maps to a view
-}


routes : List ( String, Hop.Payload -> Action )
routes =
  [ ( "/", ShowArtists )
  , ( "/artists", ShowArtists )
  , ( "/artist/:artist/edit", ShowArtistEdit )
  , ( "/artist/:artist", ShowArtist )
  ]



{-
Create a Hop router
Hop expects the a list of routes and an action for a location doesn't match
-}


router : Hop.Router Action
router =
  Hop.new
    { routes = routes
    , notFoundAction = ShowNotFound
    }
