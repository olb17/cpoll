module Common.Delay exposing (..)

import Task
import Time
import Process

delay : Time.Time -> msg -> Cmd msg
delay time msg =
  Process.sleep time
  |> Task.perform (\_ -> msg)