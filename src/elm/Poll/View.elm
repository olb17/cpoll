module Poll.View exposing (indexView)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
-- import Html.Keyed exposing (..)
import Messages exposing (..)
import Model exposing (..)


indexView : PollQuestion -> Html Msg
indexView pq =
    div
        [ id "home_index" ]
        (viewContent pq)


viewContent : PollQuestion -> List (Html Msg)
viewContent pq =
        case pq.status of
            WaitingForQuestion -> 
                [text "Wainting for question : WaitingForQuestion"]
            WaitingForAnswer -> 
                viewWaitingForAnswer pq
            WaitingForAllAnswers -> 
                viewWaitingForAllAnswers pq
            DisplayResult -> 
                [text "Wainting for question : DisplayResult"]


viewWaitingForAnswer : PollQuestion -> List (Html Msg)
viewWaitingForAnswer pq =
    List.append
        [ div []
            [ text ("Question " ++ pq.id) ]
        , div [] 
            [text pq.textMd]
        ]
        (List.map viewQuestion pq.answers)
    

viewQuestion : (String, String) -> Html Msg
viewQuestion (idQ, question) =
    div [] 
        [ input [ type_ "radio", name "font-size", onClick (SelectAnswer idQ) ] []
        , text question
        ]

viewWaitingForAllAnswers : PollQuestion -> List (Html Msg)
viewWaitingForAllAnswers pq =
    List.append
        [ div []
            [ text ("Question " ++ pq.id ++ 
                    "( " ++ toString pq.answerNb ++ " / " ++ (toString pq.participantNb) ++ " )" )
            , div [] 
                [text pq.textMd]
            ]
        ]
        (List.map viewQuestionAnswered pq.answers)
    

viewQuestionAnswered : (String, String) -> Html Msg
viewQuestionAnswered (idQ, question) =
    div [id idQ] 
        [text ("Q" ++ idQ)
        , text question
        ]

viewDisplayResult : PollQuestion -> List (Html Msg)
viewDisplayResult pq =
    List.append
        [ div []
            [ text ("Question " ++ pq.id)
            , div [] 
                [text pq.textMd]
            ]
        ]
        (List.map viewDisplayResultAnswer pq.answers)
    

viewDisplayResultAnswer : (String, String) -> Html Msg
viewDisplayResultAnswer (idQ, question) =
    div [id idQ] 
        [text ("Q" ++ idQ)
        , text question
        ]