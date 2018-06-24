module OpeningPoll.Messages exposing (..)

import Model exposing (..)

type OpeningPollMsgType
    = StartQuestion PollQuestion
    | EndQuestion PollQuestion
    | CancelQuestion PollQuestion