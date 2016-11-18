# Project: Words 4 Music

### [Project Description](doc/project4_desc.md)

![image](http://cdn.newsapi.com.au/image/v1/f7131c018870330120dbe4b73bb7695c?width=650)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**coursework login required**)
+ [Data description](doc/readme.html)
+ Contributor's name: Zhehao Liu
+ Projec title: Words 4 Music
- Method used: The method used is the combination of **prior word frequency** and **clustered word frequency**. 
  - Prior word frequency: When exploring the dataset, certain words like 'a','I', 'It', 'You' etc have consistent high frequencies across most of the songs. In order to represent this pattern in the final prediction, the probability of each word in the training data is used along with the clustered word frequency.
  - Clusted word frequency: In the belief of different types of songs can have rather different word distribution in the lyrics, a feature vector including segment_loudness, segment_pitch and segment_timbre is created for each song and then used kmeans to group all the songs in the training data into 20 clusters, for each cluster probability of each word is calculated.

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
