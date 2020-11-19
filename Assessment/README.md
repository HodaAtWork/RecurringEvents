# Programming assessment
When applying for a job you sometimes are requested to take an online IT assessment; expected or all on the sudden. For a coding job a way to test your skills. I remember doing one back in 2018. In one hour three randomly chosen programming tasks had to be solved. No internet, just a screen to program and pencil and paper. The choice of the programming language to solve the problem was free. The only language I recently used (Smalltalk) was not available and I just started to learn Python, so I decided to write some pseudo code. 
<br><br>
The real solutions were not provided, but I presume it must be like the below solution of 2 of the tasks in [Pharo](https://pharo.org) Smalltalk. The Python solution is provided in the notebook.<br><br>
The Smalltalk code below was written in the playground of a Pharo image.
```smalltalk
"programmeertest 1. Van alle permutaties van een gegeven nr de grootste teruggeven"
nr := 37839807202.
largestNrString := ''.
nrAsSortedChars := nr asString asSortedCollection reverse.
1 to: nrAsSortedChars size do: [ :i | largestNrString := largestNrString, (nrAsSortedChars at: i) asString ].
^largestNrString asNumber
```

```Smalltalk
"programmeertest 2. Verzameling ranks, waarbij gerapporteerd wordt aan de meerdere die precies 1 hoger in hierarchie staat. Retourneer totaal aantal ranks die rapporteren"
ranks := OrderedCollection new add: 3; add: 4; add: 3; add: 0; add: 2; add: 2; add: 3; add: 0; add: 0; yourself.
sortedRanks := ranks asSortedCollection.
uniqueRanks := sortedRanks asSet.
ranksDict := Dictionary new.
uniqueRanks do: [ :r | ranksDict at: r put: (sortedRanks select: [:s | r = s ]) size ].
reportedRanks := 0.
uniqueRanks do: [ :r | ranks := ranksDict at: r. (ranksDict at: r+1 ifAbsent: [ nil]) ifNotNil:[reportedRanks := reportedRanks + ranks] ]. 
^reportedRanks
```

```python

```
