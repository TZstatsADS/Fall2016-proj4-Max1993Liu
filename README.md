# Project: Words 4 Music

### [Project Description](doc/project4_desc.md)

![image](figs/2pac.jpg)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**coursework login required**)
+ [Data description](doc/readme.html)
+ Contributor: Zhehao Liu

- Method used: The method used is the combination of **prior word frequency** and **clustered word frequency**. 
  - **Prior word frequency**: When exploring the dataset, certain words like 'a','I', 'It', 'You' etc have consistent high frequencies across most of the songs. In order to represent this pattern in the final prediction, the probability of each word in the training data is used along with the clustered word frequency.
  - **Clusted word frequency**: In the belief of different types of songs can have rather different word distribution in the lyrics, a feature vector including segment_loudness, segment_pitch and segment_timbre is created for each song and then used kmeans to group all the songs in the training data into 20 clusters, for each cluster probability of each word is calculated.
  - **Make prediction**: For each and every new song, its distance between cluster centers are calculated and used as the weight to sum up word probability for each cluster, which gives us the word probability from clusters. Then the final probabiliy = 0.2 * prior word probability + 0.8 * word probability from cluster is used to generate the rank.
  - **Model validation**: Cross-validation is used to get the _number of clusters_ and _weights for prediction_.

+ Code for feature extraction and generating rank list can be found [here](lib/) 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
