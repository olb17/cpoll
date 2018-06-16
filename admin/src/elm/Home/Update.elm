module Home.Update exposing (update)

import Time

import Messages exposing (..)
import Home.Messages exposing (..)
import Poll.Messages exposing (..)
import Model exposing (..)
import Ports exposing (..)

import Common.Delay exposing (..)

update : HomeMsgType -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandlePollInput value ->
            if String.isEmpty(value)
            then
                { model | poll = Nothing } ! []
            else
                { model | poll = Just value } ! []

        HandleUsernameInput value ->
            if String.isEmpty(value)
            then
                { model | username = Nothing } ! [setUsername ""]
            else
                { model | username = Just value } ! [setUsername value]

        HandlePollSubmit ->
            let
                pq =
                    { id = "id1"
                    , status = WaitingForAnswer
                    , textMd = "Mais quelle est la question ?"
                    , answers = [ 
                                ("id1", "Question 1", 0)
                                , ("id2", "Question 2", 0)
                                , ("id3", "Question 3", 0)
                                , ("id4", "Question 4", 0)
                                ]
                    , answerId = Nothing
                    , participantNb = 10
                    , answerNb = 0
                    }
            in
                case model.poll of
                    Just pollid -> model ! 
                        [ delay (Time.second * 0) <| PollConnected
                        , delay (Time.second * 2) <| PollMsg (Poll.Messages.IncomingQuestion pq) ]
                    Nothing -> model ! []
