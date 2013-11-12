-module(gen_server_timer_issue_app).

-behaviour(application).

%% Application callbacks
-export([start/0,start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================
start()->
    application:start(gen_server_timer_issue).
start(_StartType, _StartArgs) ->
    {ok,Pid}=gen_server_timer_issue:start_link(),
    gen_server_timer_issue:test(),
    {ok,Pid}.

stop(_State) ->
    ok.
