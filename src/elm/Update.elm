module Update exposing (..)

import Time
import Debug

import Routing exposing (Route(..), parse, toPath)
import Messages exposing (..)
import Model exposing (..)
import Navigation
import Home.Update exposing (..)
import AdminHome.Update exposing (..)
import Poll.Update exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg homeMsgType ->
            Home.Update.update homeMsgType model
        
        AdminHomeMsg adminHomeMsgType ->
            AdminHome.Update.update adminHomeMsgType model
        
        PollMsg pollMsgType ->
            Poll.Update.update pollMsgType model
        
        PollConnected ->
            let 
                pollid = case model.poll of
                    Just u -> u
                    Nothing -> ""
            in
                update (NavigateTo (ParticipateToPollRoute pollid)) 
                    { model | pollQuestion = initPollQuestion }
             
        UrlChange location ->
            let
                currentRoute = parse location
            in
                urlUpdate { model | route = currentRoute }

        NavigateTo route ->
            model ! [ Navigation.newUrl <| toPath route ]


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.route of
        HomeIndexRoute ->
            model ! []

        AdminHomeRoute ->
            model ! []

        ParticipateToPollRoute poll ->
            if model.username /= Nothing && model.poll /= Nothing then            
                { model | pollQuestion = initPollQuestion } ! []
            else
                urlUpdate { model | route = HomeIndexRoute }

        _ ->
            model ! []
