season3_2009games <- read.csv(file="data/2009_season3.csv", head=FALSE)
season3_2010games <- read.csv(file="data/2010_season3.csv", head=FALSE)

# merge data from two files, and appropriately name the headings
games <- rbind(season3_2009games, season3_2010games)
names(games) <- c("GameDate", "DateCount", "HomeID", "AwayID", "HomePts", "AwayPts", "HomeAbbr", "AwayAbbre", "HomeName", "AwayName")

# store home and away points
awayPts <- games[,"AwayPts"]
homePts <- games[,"HomePts"]

# declare home and away points scored
homePtsScored <- aggregate(HomePts~HomeName, games, sum)
awayPtsScored <- aggregate(AwayPts~AwayName, games, sum)

# declare totalPtsScored, and name columns in data frame
totalPtsScored <- data.frame(homePtsScored$HomeName, homePtsScored$HomePts + awayPtsScored$AwayPts)
names(totalPtsScored) <- c("TeamName", "Total")

# sort, finding highest
print(head(totalPtsScored[order(-totalPtsScored$Total),]))