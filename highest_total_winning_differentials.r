season3_2009games <- read.csv(file="data/2009_season3.csv", head=FALSE)
season3_2010games <- read.csv(file="data/2010_season3.csv", head=FALSE)

# merge data from two files, and appropriately name the headings
games <- rbind(season3_2009games, season3_2010games)
names(games) <- c("GameDate", "DateCount", "HomeID", "AwayID", "HomePts", "AwayPts", "HomeAbbr", "AwayAbbre", "HomeName", "AwayName")

# store home and away points
awayPts <- games[,"AwayPts"]
homePts <- games[,"HomePts"]

# transform to add two new columns, homeWins and awayWins
games <- transform(games, homeWins = homePts > awayPts, awayWins = homePts < awayPts)

# home and away winning scores are declared
homeWins <- subset(games, homeWins == TRUE)
awayWins <- subset(games, awayWins == TRUE)

homeWinningDifferential <- homeWins$HomePts - homeWins$AwayPts
totalHomeWinningDifferential <- aggregate(homeWinningDifferential~HomeName, data=homeWins, FUN="sum")
names(totalHomeWinningDifferential) <- c("homeName", "Pts")

awayWinningDifferential <- awayWins$HomePts - awayWins$AwayPts
totalAwayWinningDifferential <- aggregate(awayWinningDifferential~AwayName, data=awayWins, FUN="sum")
names(totalAwayWinningDifferential) <- c("awayName", "Pts")

# create a data frame of the total overall winning differential
totalOverallWinningDifferential <- data.frame(totalHomeWinningDifferential$homeName, totalHomeWinningDifferential$Pts + (totalAwayWinningDifferential$Pts * -1))
names(totalOverallWinningDifferential) <- c("TeamName", "Pts")

# sort normally
print(head(totalOverallWinningDifferential[order(-totalOverallWinningDifferential$Pts),]))