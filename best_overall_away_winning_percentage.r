season3_2009games <- read.csv(file="data/2009_season3.csv", head=FALSE)
season3_2010games <- read.csv(file="data/2010_season3.csv", head=FALSE)

# merge data from two files, and appropriately name the headings
games <- rbind(season3_2009games, season3_2010games)
names(games) <- c("GameDate", "DateCount", "HomeID", "AwayID", "HomePts", "AwayPts", "HomeAbbr", "AwayAbbre", "HomeName", "AwayName")

# store home and away points
awayPts <- games[,"AwayPts"]
homePts <- games[,"HomePts"]

# store home wins
awayWins <- homePts < awayPts

# sum of away wins, aggregated by HomeName
sumAwayWins <- aggregate(awayWins~HomeName, data=games, FUN="sum")

# number of away games, by team name
sumAwayGames <- table(games["HomeName"])

# put away wins, and number of away games together into a single frame
combinedWins <- data.frame(sumAwayWins, sumAwayGames)
combinedWins <- subset(combinedWins, select=-c(Var1))
names(combinedWins) <- c("AwayName", "awayWins", "sumAwayGames")

# transform to have a new column, win percentage
overallAwayWinningPercentage = transform(combinedWins, awayWinningPercentage = (combinedWins$awayWins/combinedWins$sumAwayGames)*100)

# print the top entries of data frame overallWinningPercentage, ordered by the highest win percentages
print(head(overallAwayWinningPercentage[order(-overallAwayWinningPercentage$awayWinningPercentage),]))