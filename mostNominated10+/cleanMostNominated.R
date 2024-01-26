

nom <- read.csv("mostNominationsByFilm.csv")

nom_processed <- nom %>%
  +     separate(category, into = c("category", "name"), sep = " -- ")

nom_processed <- nom_processed %>%
  +     filter(!is.na(name), discount != "x")

nom_processed2 <- nom_processed %>%
 mutate(role = ifelse(str_detect(name, "\\{.*\\}"), 
 str_extract(name, "\\{(.*)\\}"), 
 NA_character_)) %>%
 mutate(name = ifelse(!is.na(role), 
  str_replace(name, "\\s*\\{.*\\}", ""), name))

nom_processed3 <- nom_processed2 %>%
  mutate(category2 = ifelse(str_detect(category, "\\(.*\\)"), 
  str_extract(category, "\\((.*)\\)"), 
  NA_character_)) %>%
  mutate(category = ifelse(!is.na(category2),str_replace(category, "\\s*\\(.*\\)", ""), category))

nom_percentages <- nom_processed3 %>% group_by(film) %>%
 summarise(
     win_count = sum(won == "won"),
     total_count = n(),
     win_percentage = (win_count / total_count) * 100
     )

write_csv(nom_percentages,"mostNominationsByFilmPercentWin.csv")
