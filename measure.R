
wd <-getwd()
setwd("/home/maciej/Documents/Rs/Measure_distance/pdb")
pdbdir<- getwd()

library(bio3d)

dcd <- read.dcd("GHx4_out.dcd")

#atoms to pick
{
{atom1 <- c(17, 23, 41, 47, 65, 71, 89, 95)
atom2 <- c(17, 23, 41, 47, 65, 71, 89, 95)
jpeg(file = as.character(atom1), width=6200, height=6200)
par(mfrow=c(length(atom1), length(atom2)))
}
#parameters for the loop
{
a <- 1
c <- 1
}


#loop1
  while (c <= (length(atom1)) ) {
#loop2
    while (a <= length(atom2)) { 

a1 <- atom1[c]
a2 <- atom2[a]
char1 <- NULL
char2 <- NULL
#atom1 xyz

a1p3 <- a1*3      ##z
a1p2 <- a1p3 -1   ##y
a1p1 <- a1p2 -1   ##x

#atom2 xyz

a2p3 <- a2*3      ##z
a2p2 <- a2p3 -1   ##y
a2p1 <- a2p2 -1   ##x

#create data frame and calculate distance from coordinates
df<-NULL
final_df<-0
df <- data.frame((dcd[,a1p1]), (dcd[,a2p1]), #x1 x2
                 (dcd[,a1p2]), (dcd[,a2p2]), #y1 y2
                 (dcd[,a1p3]), (dcd[,a2p3])) #z1 z2

colnames(df) <- c("a1x", "a2x", "a1y", "a2y", "a1z", "a2z")

df[,7] <- sqrt((df[,1] - df[,2])^2)
colnames(df)[7] <- c("xdiffabs")
df[,8] <- sqrt((df[,3] - df[,4])^2)
colnames(df)[8] <- c("ydiffabs")
df[,9] <- sqrt((df[,5] - df[,6])^2)
colnames(df)[9] <- c("zdiffabs")

df[,10] <- ( sqrt( (df[, 7])^2 + (df[, 8])^2))
colnames(df)[10] <- c("xypitagoras")
df[,11] <- ( sqrt( (df[, 9])^2 + (df[, 10])^2))
colnames(df)[11] <- c("distance")

#control of calculated values with external file works for only coordinates for 2 atoms
#control <- read.delim("vmd_dist.dat", header = F)
#colnames(control) <- c("time", "distance")
#print(head(control))

#df[,12] <- control[, 2]
#colnames(df)[12] <- c("control")

##check
#df[,13] <- { (df[, 11]) - (df[, 12])}
#colnames(df)[13] <- c("difference")
#df[,14] <- isTRUE(df[1,13] >= 0.00001)

frame <- c(1:1001)
final_df <- data.frame(frame)
final_df[,2] <- df[,11]
colnames(final_df)[2] <- c("distance")

char1 <- (as.character(a1))
char2 <- (as.character(a2))
charvect <- c(char1, "and", char2, ".jpeg")

xD <- paste(charvect, collapse  = '')

#plotting

plot(final_df, type = "l", main = xD, xlim=c(0,1000), ylim = c(0, 20), col ="red")



a <- a +1
}
  c <- c+1
  a <- 1
    }
  dev.off()
}
