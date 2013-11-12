all: compile

compile:
	rebar compile

run: 
	erl -pa ebin -s gen_server_timer_issue_app

clean: 
	rebar clean
