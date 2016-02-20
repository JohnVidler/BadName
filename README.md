# BadName

Ever been told that your sports car's name means "small penis" in Spanish? Worried about branding yourself as an asshole? Then I have the tool for you!

Got a hip new chat service for schools?

```
$ julia BadNameCmd.jl "SkoolIM"
2 results:
schlemeil (yiddish) : always spills his soup  [imperfect match]
schlampe (german) : tramp or slut  [imperfect match]
```

Change the name in Germany!

The possibilities are endless. What's that? You've got a whole database of brand names to test? Absolutely _need_ to know which of your coworkers' given names is most insulting? Well, load on up the `BadName` library.

```{julia}
using BadName
badname("Peter")
# 1-element Array{Dict{ASCIIString,Any},1}:
# Dict{ASCIIString,Any}("meaning"=>"tits","language"=>"swedish","word"=>"pattar","permissive"=>false)
```

Now you can have full control over whether to send Peter to Sweden!

## Prerequisites 

The `Phonetics` library [available here](https://github.com/Betawolf/Phonetics.jl)
