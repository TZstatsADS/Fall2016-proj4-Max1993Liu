auto_fill = function(vector, thre){
    if (length(vector) >= thre){
        return(vector[1:thre])
    }  else{
        num_fill = thre - length(vector)
        vector = c(vector,sample(vector, num_fill, replace = T))
        return(vector)
    }
}

get_single_feature = function(filename){
    sound_info = h5read(filename, "/analysis")
    
    #song_name = sound_info$songs$track_id
    num_beats = length(sound_info$beats_start)
    num_section = length(sound_info$sections_start)
    num_segment = length(sound_info$segments_start)
    mean_pitch = auto_fill(colMeans(sound_info$segments_pitches), 750)
    seg_loudness = auto_fill(sound_info$segments_loudness_max, 750)
    seg_timbre = auto_fill(sound_info$segments_timbre, 750)
    
    temp_feature = c(num_beats, num_section, num_segment,  seg_loudness,seg_timbre,  mean_pitch)
    H5close()
    return(temp_feature)
}

get_features = function(files){
    total = length(files)
    feature_vector = as.numeric()
    for (i in seq(length(files))){
        feature_vector = c(feature_vector, get_single_feature(files[i]))
        print(paste0(i,'/',total,' completed!'))
    }
    features = matrix(feature_vector, nrow = total, byrow = T)
    features = as.data.frame(features)
    names = sapply(files, FUN = function(x){return(substr(x,nchar(x) -20, nchar(x)-3))}, USE.NAMES = F)
    features = cbind(names, features)
    return(features)
}
