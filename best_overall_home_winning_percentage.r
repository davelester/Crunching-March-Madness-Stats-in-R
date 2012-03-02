season3_2009games <- read.csv(file="data/2009_season3.csv", head=FALSE)
season3_2010games <- read.csv(file="data/2010_season3.csv", head=FALSE)

# merge data from two files, and appropriately name the headings
games <- rbind(season3_2009games, season3_2010games)
names(games) <- c("GameDate", "DateCount", "HomeID", "AwayID", "HomePts", "AwayPts", "HomeAbbr", "AwayAbbre", "HomeName", "AwayName")

# store home and away points
awayPts <- games[,"AwayPts"]
homePts <- games[,"HomePts"]

# store home wins
homeWins <- homePts > awayPts

# sum of home wins, aggregated by HomeName
sumHomeWins <- aggregate(homeWins~HomeName, data=games, FUN="sum")

# number of home games, by team name
sumHomeGames <- table(games["HomeName"])

# put home wins, and number of home games together into a single frame
combinedWins <- data.frame(sumHomeWins, sumHomeGames)
combinedWins <- subset(combinedWins, select=-c(Var1))
names(combinedWins) <- c("homeName", "homeWins", "sumHomeGames")

# transform to have a new column, win percentage
overallHomeWinningPercentage = transform(combinedWins, homeWinningPercentage = (combinedWins$homeWins/combinedWins$sumHomeGames)*100)

# print the top entries of data frame overallWinningPercentage, ordered by the highest win percentages
print(head(overallHomeWinningPercentage[order(-overallHomeWinningPercentage$homeWinningPercentage),]))