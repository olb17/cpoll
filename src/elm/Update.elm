module Update exposing (..)

import Time

import Routing exposing (Route(..), parse, toPath)
import Messages exposing (..)
import Model exposing (..)
import Navigation
import Common.Delay exposing (..)
import Home.Update exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg homeMsgType ->
            Home.Update.update homeMsgType model
        
        PollConnected ->
            let 
                pollid = case model.poll of
                    Just u -> u
                    Nothing -> ""
            in
                update (NavigateTo (ParticipateToPollRoute pollid)) 
                    { model | pollQuestion = initPollQuestion }
        
        IncomingQuestion pq ->
            { model | pollQuestion = pq } ! []
        
        SelectAnswer idAnswer ->
            let
                pq = model.pollQuestion
                pqUpdated = { pq | answerId = Just idAnswer
                                 , status = WaitingForAllAnswers
                            }
            in
                { model | pollQuestion = pqUpdated } ! 
                    [
                    delay (Time.second * 1) <| UpdatedAnswerNb 2
                    , delay (Time.second * 2) <| UpdatedAnswerNb 4
                ]

        UpdatedAnswerNb nbAnswers ->
            let
                pq = model.pollQuestion
                pqUpdated = { pq | answerNb = nbAnswers }
            in
                { model | pollQuestion = pqUpdated } ! []
             
        UrlChange location ->
            let
                currentRoute =
                    parse location
            in
                urlUpdate { model | route = currentRoute }

        NavigateTo route ->
            model ! [ Navigation.newUrl <| toPath route ]


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.route of
        HomeIndexRoute ->
            model ! []

        _ ->
            model ! []
