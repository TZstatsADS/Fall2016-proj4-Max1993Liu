#setup
setwd('/Users/Max/Downloads/Project4_data/')
library(rhdf5)
library(dplyr)
source('feature.R')

files = list.files(path ='.',pattern = '*.h5', recursive = T)
file_names = basename(files)
load('./lyr.RData')
lyr = lyr[,-c(2,3,6:30)]

#-----features------------
#1. beats/duration
#2. key 
#3. loudness
#4. number of sections
#5. bin_count of section start/duration
#6. mean of loudness
#7. number of segments
#8. pitch
#9. time_signature
#10. tempo
#11. duration

test = get_features(files)

#kmeans into 20 clusters
km = kmeans(test[,-1], 20)

song_cluster = data.frame(song = as.vector(test$names), cluster = km$cluster)
lyr = left_join(song_cluster, lyr, by = c('song' = 'dat2$track_id'))
lyr_prob = subset(lyr, select = -song)
lyr_prob = aggregate(.~cluster, data = lyr_prob, sum)

#probability of words for each cluster
#the value doesn't matter, so multiply by 1000 to prevent problems on very small values
temp = lyr_prob[,-1]
probability = apply(temp, MARGIN = 1, FUN = function(x){return(1000*x/sum(x))})
probability = t(probability)
cluster_prob = as.data.frame(cbind(lyr_prob$cluster, probability))

#prior probability
load('./lyr.RData')
lyr = lyr[,-c(2,3,6:30)]
word_freq = colSums(lyr[,-1])
prior_prob = 1000 * word_freq/sum(word_freq)

word_rank = function(new_features){
  #calculate distance for new features
  new = new_features[-1]
  
  Total = nrow(new)
  dis = as.matrix(dist(rbind(as.matrix(new), km$centers), upper = T))
  new_dis = dis[1:Total,(Total+1):ncol(dis)]
  
  rank_list = as.numeric()
  for(i in seq(Total)){
      weighted_prob = t(as.matrix(cluster_prob[-1])) %*% (new_dis[i,])
      #prior probability + clustered probability
      final_weight = 0.2 * prior_prob + 0.8 * weighted_prob
      #get the rank
      rank_list = rbind(rank_list, rank(final_weight))
  }
  rank_list = as.data.frame(rank_list)
  return(rank_list)
}
