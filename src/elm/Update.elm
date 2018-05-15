module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Navigation
import Task
import Time
import Process
import Routing exposing (Route(..), parse, toPath)


update : Msg -> Model -> ( Model, Cmd Msg )
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
                { model | username = Nothing } ! []
            else
                { model | username = Just value } ! []

        HandlePollSubmit ->
            let
                pq =
                    { id = "id1"
                    , status = WaitingForAnswer
                    , textMd = "Mais quelle est la question ?"
                    , answers = [ 
                                ("id1", "Question 1")
                                , ("id2", "Question 2")
                                , ("id3", "Question 3")
                                , ("id4", "Question 4")
                                ]
                    , answerId = Nothing
                    , participantNb = 10
                    , answerNb = 0
                    }         
            in
                case model.poll of
                    Just pollid -> model ! 
                        [ delay (Time.second * 0) <| PollConnected
                        , delay (Time.second * 2) <| IncomingQuestion pq ]
                    Nothing -> model ! []
        
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

delay : Time.Time -> msg -> Cmd msg
delay time msg =
  Process.sleep time
  |> Task.perform (\_ -> msg)