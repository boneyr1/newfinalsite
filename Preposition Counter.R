#Here is my preposition counter.:


prepositions_counter <- function(sentence) {
  prepositions <- c("about", "above", "across", "after", "against", "along", "among", "around", "at", "before", "behind", "below", "beneath", "beside", "between", "beyond", "but", "by", "concerning", "considering", "despite", "down", "during", "except", "for", "from", "in", "inside", "into", "like", "near", "of", "off", "on", "onto", "out", "outside", "over", "past", "regarding", "round", "since", "through", "throughout", "to", "toward", "under", "underneath", "until", "up", "upon", "with", "within", "without")
  words <- unlist(strsplit(sentence, " "))
  prep_num <- sum(words %in% prepositions)
  return(prep_num)
}

#Create a variable with a string, then run it in the function preposition_counter.
#You can also load csv files in and run the function on the file
#It will return the number of prepositions in the code
#Example:

y <- "Today he went out and about. He went above and beyond"

prepositions_counter(y)

