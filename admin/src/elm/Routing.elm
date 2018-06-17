module Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = AdminHomeRoute
    | OpeningPollRoute String
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        AdminHomeRoute ->
            "/"

        OpeningPollRoute id ->
            "/#openingPoll/" ++ id
        
        NotFoundRoute ->
            "/#not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map AdminHomeRoute <| s ""
        , map OpeningPollRoute <| s "openingPoll" </> string
        ]


parse : Navigation.Location -> Route
parse location =
    let
      locationHash =
        if String.isEmpty(location.hash)
        then { location | hash = "#/" }
        else location
    in        
        case UrlParser.parseHash matchers locationHash of
            Just route ->
                route

            Nothing ->
                NotFoundRoute
