args = commandArgs(trailingOnly=TRUE)
library(cummeRbund)
#setwd("/")
#cuff<-readCufflinks(args[12])
cuff<-readCufflinks(dir=args[11] ,dbFile="cuffData.db" , repTableFile =  args[3] , geneFPKM =  args[2] ,geneDiff =  args[10] , geneCount= args[4], geneRep=  args[5] ,isoformFPKM =  args[6] , isoformDiff =  args[9] , isoformCount=  args[8] , isoformRep= args[7])
sink('cuff.txt')
print(cuff)
sink()


