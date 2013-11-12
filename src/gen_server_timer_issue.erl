%%%-------------------------------------------------------------------
%%% @author Tthread <tthread@gmail.com>
%%% @copyright (C) 2013, Eltex
%%% @doc
%%%
%%% @end
%%% Created : 12 Nov 2013 by Tthread <tthread@gmail.com>
%%%-------------------------------------------------------------------
-module(gen_server_timer_issue).

-behaviour(gen_server).

%% API
-export([start_link/0,test/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

-define(SERVER, ?MODULE).
-define(TEST_TIME, 5000).
-define(SLEEP_TIME,1000).

-record(state, {timeout}).

%%%===================================================================
%%% API
%%%===================================================================
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

test()->
    gen_server:cast(?MODULE,cast).
%%%===================================================================
%%% gen_server callbacks
%%%===================================================================
init([]) ->
    timer:send_after(?TEST_TIME,exit),
    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.


handle_cast(cast, State) ->
    io:format("Sended cast~n",[]),
    timer:sleep(?SLEEP_TIME),
    %% Breaking the gen_server timer
    gen_server:cast(self(),cast),
    %% Set timeout to 0
    {noreply, State,0};
handle_cast(_Msg, State) ->
    {noreply, State}.

%% Timeout will never comes
handle_info(timeout, State) ->
    io:format("Timeout comes~n",[]),
    {noreply, State#state{timeout=timeout}};
%% Received exit signal
handle_info(exit,#state{timeout=undefined}=State)->
    io:format("Timeout message doesn't come."),
    {stop,normal,State};
handle_info(_Info, State) ->
    io:format("~p~n",[_Info]),
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
