with Chess; use Chess;
with Move; use Move;

package Perft_func is
	function perft_all(b : in Board; p : in Player; depth : in Integer; prev : in String) return Integer;
end Perft_func;