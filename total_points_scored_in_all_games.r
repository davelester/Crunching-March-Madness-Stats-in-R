season3_2009games <- read.csv(file="data/2009_season3.csv", head=FALSE)
season3_2010games <- read.csv(file="data/2010_season3.csv", head=FALSE)

# merge data from two files, and appropriately name the headings
games <- rbind(season3_2009games, season3_2010games)
names(games) <- c("GameDate", "DateCount", "HomeID", "AwayID", "HomePts", "AwayPts", "HomeAbbr", "AwayAbbre", "HomeName", "AwayName")

# store home and away points
awayPts <- games[,"AwayPts"]
homePts <- games[,"HomePts"]

totalAwayPts <- aggregate(awayPts~HomeName, data=games, FUN="sum")
totalHomePts <- aggregate(homePts~HomeName, data=games, FUN="sum")

#sum of total away points, and total home points
sum(totalAwayPts$awayPts) + sum(totalHomePts$homePts)