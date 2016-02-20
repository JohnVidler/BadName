module BadName

using Phonetics

type SwearDict
  " dictionary to reference "
  lookup::Dict{ASCIIString, Any}
  " reference for lookup "
  kvals::Array{ASCIIString,1}
end


"""
  `init(file)`
  
  initialises the internal swearword dictionary from a CSV file of the
  format _word_, _language_, _meaning_. 
"""
function init(dbfile)
  data = readcsv(dbfile)

  collen = size(data)[1]

  lookup = Dict{ASCIIString, Any}([(data[i], Dict("word"=>data[i], "language"=>data[collen+i], "meaning"=>data[2*collen+i], "permissive"=>false)) for i in 1:collen])

  kvals = collect(keys(lookup))
  return SwearDict(lookup, kvals)
end

#default swear file
defaultdict = init("data/swears.csv")

"""
  `badname(word)`

  Attempts to phonetically match the word with the known dictionary of bad words. 

  Returns either an array of `Dict` objects describing matches or `nothing`. 

  The function will automatically retry a search with a more permissive setting if
  nothing comes up as an exact (phonetic) match. 
"""
function badname(word, dict=defaultdict)
  #locally overwrite the metaphone default
  lmetaphone(x) = metaphone(x, 6)

  #search for exact matches
  exact = code_match(word, dict.kvals, lmetaphone)
  if length(exact) > 0
    #If found, return associated values.
    return map(x -> dict.lookup[x], exact)
  else
    #Else search for permissive matches.
    permissive = code_match(word, dict.kvals, lmetaphone, 0.8)
    if length(permissive) > 0
      return map(permissive) do x
        d = dict.lookup[x]
        d["permissive"] = true
        return d
      end
    else
      return nothing
    end
  end
end


"""
  `print_result(d)`

  A custom print function for results of `badname`.
"""
function print_result(d)
  if d["permissive"]
    println(d["word"], " (", d["language"], ") : ", d["meaning"], "  [imperfect match]")
  else
    println(d["word"], " (", d["language"], ") : ", d["meaning"])
  end
end

export badname, print_result, init
end
