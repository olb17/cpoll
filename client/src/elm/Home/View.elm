module Home.View exposing (indexView)

-- import Common.View exposing (warningMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
-- import Html.Keyed exposing (..)
import Messages exposing (..)
import Home.Messages exposing (..)
import Model exposing (..)
import Routing exposing (..)


indexView : Model -> Html Msg
indexView model =
    div
        [ id "home_index" ]
        (viewContent model)


viewContent : Model -> List (Html Msg)
viewContent model =
    [ div []
        [ text "Poll id : "
        , input [ placeholder "Poll id ..."
                , type_ "text"
                , value (Maybe.withDefault "" model.poll)
                , onInput <| raiseLocalInputMsg HandlePollInput
                ]
            []
        ]
    , div []
        [ text "Username : "
        , input [ placeholder "Username ..."
                , type_ "text"
                , value (Maybe.withDefault "" model.username)
                , onInput <| raiseLocalInputMsg HandleUsernameInput
                ]
            []
        ]
    , input [ type_ "button", value "Join Existing Poll", onClick <| HomeMsg HandlePollSubmit ]
        []
    ]

raiseLocalInputMsg: (String -> HomeMsgType) -> (String -> Msg)
raiseLocalInputMsg msg =
    \x -> HomeMsg (msg x)
