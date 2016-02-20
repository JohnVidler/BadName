using BadName
using ArgParse

function main(args)

  argparser = ArgParseSettings("Find out what a word might sound like in another language.")
  @add_arg_table argparser begin
    "word"
      help = "A word to check."
      required = true
    "--db"
      help = "A CSV file containing <word>,<language>,<meaning>"
      required = false
  end

  parsed_args = parse_args(args, argparser)

  if parsed_args["db"] != nothing
    altdb = init(parsed_args["db"])
    results = badname(parsed_args["word"], altdb)
  else
    results = badname(parsed_args["word"])
  end

  if results == nothing
    println("No results.")
  else
    lr = length(results)
    println(lr, " result", lr > 1 ? "s:": ":")
    for result in results
      print_result(result)
    end
  end
end

main(ARGS)
