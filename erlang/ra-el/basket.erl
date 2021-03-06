-module(basket).
-compile(export_all).

start(InitialItems) ->
	spawn(?MODULE, loop, [InitialItems]).

examine(Pid) ->
  Pid ! {self(), examine}, % self() is the calling process ID
	receive
		{Pid, State} -> State
	end.

add(Pid, Item) ->
	Pid ! {self(), add, Item},
	receive
		{Pid, Status} -> Status
	end.

remove(Pid, Item) ->
	Pid ! {self(), remove, Item},
	receive
		{Pid, Status} -> Status
	end.

loop(State) ->
	receive
		{From, examine} ->
			From ! {self(), State},
			loop(State);
		{From, add, Item} ->
			From ! {self(), ok},
			loop([Item|State]);
		{From, remove, Item} ->
			case lists:member(Item, State) of
				true ->
					From ! {self(), ok},
					loop(lists:delete(Item, State));
				false ->
					From ! {self(), not_found},
					loop(State)
			end
	end.
