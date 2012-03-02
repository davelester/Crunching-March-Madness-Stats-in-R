season3_2009games <- read.csv(file="data/2009_season3.csv", head=FALSE)
season3_2010games <- read.csv(file="data/2010_season3.csv", head=FALSE)

# merge data from two files, and appropriately name the headings
games <- rbind(season3_2009games, season3_2010games)
names(games) <- c("GameDate", "DateCount", "HomeID", "AwayID", "HomePts", "AwayPts", "HomeAbbr", "AwayAbbre", "HomeName", "AwayName")

# store home and away points
awayPts <- games[,"AwayPts"]
homePts <- games[,"HomePts"]

# store home and away wins
awayWins <- homePts < awayPts
homeWins <- homePts > awayPts

# sum of home and away wins, aggregated by HomeName
sumHomeWins <- aggregate(homeWins~HomeName, data=games, FUN="sum")
sumAwayWins <- aggregate(awayWins~AwayName, data=games, FUN="sum")

# number of home and away games, by team name
sumHomeGames <- table(games["HomeName"])
sumAwayGames <- table(games["AwayName"])

# put wins (sumHomeWins and sumAwayWins), and number of games (sumHomeGames and sumAwayGames) together into a single frame
combinedWins <- data.frame(sumHomeWins, sumAwayWins, sumHomeGames, sumAwayGames)
combinedWins <- subset(combinedWins, select=-c(AwayName,Var1,Var1.1))
names(combinedWins) <- c("homeName", "homeWins", "awayWins", "sumHomeGames", "sumAwayGames")

# total up the games and wins
totalGames <- sumHomeGames + sumAwayGames
totalWins <- sumHomeWins$homeWins + sumAwayWins$awayWins

# transform to have a new column, win percentage
overallWinningPercentage = transform(combinedWins, winningPercentage = (totalWins/totalGames)*100)

# print the top entries of data frame overallWinningPercentage, ordered by the highest win percentages
print(head(overallWinningPercentage[order(-overallWinningPercentage$winningPercentage.Freq),]))