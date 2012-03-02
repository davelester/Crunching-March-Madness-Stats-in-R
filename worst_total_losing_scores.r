season3_2009games <- read.csv(file="data/2009_season3.csv", head=FALSE)
season3_2010games <- read.csv(file="data/2010_season3.csv", head=FALSE)

# merge data from two files, and appropriately name the headings
games <- rbind(season3_2009games, season3_2010games)
names(games) <- c("GameDate", "DateCount", "HomeID", "AwayID", "HomePts", "AwayPts", "HomeAbbr", "AwayAbbre", "HomeName", "AwayName")

# store home and away points
awayPts <- games[,"AwayPts"]
homePts <- games[,"HomePts"]

# transform to add two new columns, homeLosses and awayLosses
games <- transform(games, homeLosses = homePts < awayPts, awayLosses = homePts > awayPts)

# home and away losing scores are declared
homeLosses <- subset(games, homeLosses == TRUE)
awayLosses <- subset(games, awayLosses == TRUE)

# combine all home and away losing scores
totalHomeLosingScores <- aggregate(HomePts~HomeName, data=homeLosses, FUN=sum)
totalAwayLosingScores <- aggregate(AwayPts~AwayName, data=awayLosses, FUN=sum)

# total losing scores are the sum of all of those losing scores
totalLosingScores <- data.frame(totalHomeLosingScores$HomeName, totalHomeLosingScores$HomePts + totalAwayLosingScores$AwayPts)
names(totalLosingScores) <- c("teamName", "totalLosingScore")

# worst total losing score is the last entry in an ordered list of total losing scores
print(tail(totalLosingScores[order(-totalLosingScores$totalLosingScore),]))