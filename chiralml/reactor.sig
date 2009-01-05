structure ChiralCommon = struct

  datatype block_cond = BLOCK_RD | BLOCK_WR

end

signature THREAD_COMMON = sig

  type 'a t
  type 'a runnable

  val new: ('a -> unit) -> 'a t
  val prepare: 'a t * 'a -> 'a runnable
  val switch: ('a t -> 'a runnable) -> 'a

end

signature REACTOR = sig

  exception NotRunning
  exception AlreadyRunnable

  val block: ('af, 't) Socket.sock * ChiralCommon.block_cond -> unit
  val sleep: Time.time -> unit

  type thread

  val new: (unit -> unit) -> thread
  val kill: thread -> exn -> unit

  val deschedule: unit -> unit
  val make_runnable: thread -> unit
  val self: unit -> thread

  val run: unit -> unit

end
