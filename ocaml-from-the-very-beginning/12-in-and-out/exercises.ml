let read_lines (filename: string) : string list =
  let ch = open_in filename in
  let try_read () =
    try Some (input_line ch) with End_of_file -> None in  
  let rec loop acc = match try_read () with
    | Some line -> loop (line :: acc)
    | None ->
      close_in ch;
      List.rev acc in
  loop []

let read_lines_alt (filename: string) : string list =
  let contents = In_channel.with_open_bin filename In_channel.input_all in
  String.split_on_char '\n' contents


let () =
  let lines = read_lines_alt "file.txt" in
  let rec process_lines = function
    | [] -> ()
    | h :: t ->
      print_endline h;
      process_lines t;
    flush stdout; in
  process_lines lines
