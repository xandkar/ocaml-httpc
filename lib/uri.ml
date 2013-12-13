open Printf

module S = StringLabels

module Scheme_http :
sig
  type t

  val make :  protocol : string
           -> domain   : string
           -> port     : int
           -> path     : string list
           -> t

  val to_string : t -> string
end = struct
  type t = string

  let make ~protocol ~domain ~port ~path =
    let parts = (sprintf "%s://%s:%d" protocol domain port) :: path in
    S.concat parts ~sep:"/"

  let to_string t =
    t
end

type t =
  | Http of Scheme_http.t

let to_string = function
  | Http s -> Scheme_http.to_string s

let make ~protocol ~domain ~port ~path =
  (* TODO: Validation *)
  match protocol with
  | Protocol.Http | Protocol.Https ->
    let protocol = Protocol.to_string protocol in
    `Ok (Http (Scheme_http.make ~protocol ~domain ~port ~path))