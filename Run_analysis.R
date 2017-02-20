verify_required_lib <- function() {
    if( !is.element("reshape", installed.packages()) ) {
        install.packages("reshape")
    }
}

verify_required_lib()

library(reshape)

download_dataset <- function() {
    file_name <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(file_name, destfile = "uci_har_dataset.zip", method = "curl")
}

extract_dataset <- function() {
    unzip("uci_har_dataset.zip", exdir = "data")
}

import_dataset <- function() {
    features_path <- paste(getwd(), "UCI HAR Dataset", "features.txt", sep = "/")
    activity_labels_path <- paste(getwd(), "UCI HAR Dataset", "activity_labels.txt", sep = "/")
    
    dataset_train_path <- paste(getwd(), "UCI HAR Dataset", "train", "X_train.txt", sep = "/")
    dataset_train_labels_path <- paste(getwd(), "UCI HAR Dataset", "train", "y_train.txt", sep = "/")
    dataset_train_subject_path <- paste(getwd(), "UCI HAR Dataset", "train", "subject_train.txt", sep = "/")

    features_vec <- read.table(features_path)
    activity_labels_vec <- read.table(activity_labels_path)
    
    
    train_df <- read.table(dataset_train_path)
    train_labels <- read.table(dataset_train_labels_path)
    train_subject <- read.table(dataset_train_subject_path)
    
    features_labels <- as.character(features_vec$V2)
    
    activity_levels <- activity_labels_vec$V1
    activity_labels <- as.character(activity_labels_vec$V2)
    
    train_labels <- unlist(train_labels)
    
    print(dim(train_labels))
    print(length(train_labels))
    print(class(train_labels))
    
    #train_labels <- unlist(train_labels)
    
    train_labels <- factor( train_labels, 
                            levels = activity_levels, 
                            labels = activity_labels )
    
    print(dim(train_labels))
    print(length(train_labels))
    print(class(train_labels))
    
    names(train_labels) <- c("train_labels")
    names(train_subject) <- c("subject")
    names(train_df) <- features_labels
    
    train_df_merged <- cbind(train_subject, train_labels, train_df)
    
    names(train_df_merged) <- c("subject", "activity", features_labels)
    
    
    dataset_test_path <- paste(getwd(), "UCI HAR Dataset", "test", "X_test.txt", sep = "/")
    dataset_test_labels_path <- paste(getwd(), "UCI HAR Dataset", "test", "y_test.txt", sep = "/")
    dataset_test_subject_path <- paste(getwd(), "UCI HAR Dataset", "test", "subject_test.txt", sep = "/")
    
    test_df <- read.table(dataset_test_path)
    test_labels <- read.table(dataset_test_labels_path)
    test_subject <- read.table(dataset_test_subject_path)
    
    test_labels <- unlist(test_labels)
    
    test_labels <- factor( test_labels, 
                           levels = activity_levels, 
                           labels = activity_labels )
    
    #test_labels <- factor(test_labels, levels = activity_labels_vec$V1, labels = as.character(activity_labels_vec$V2))
    
    names(test_labels) <- c("train_labels")
    names(test_subject) <- c("subject")
    names(test_df) <- features_labels
    
    test_df_merged <- cbind(test_subject, test_labels, test_df)
    
    names(test_df_merged) <- c("subject", "activity", features_labels)
    
    df <- rbind(train_df_merged, test_df_merged)
    
    #print(dim(test_df))
    #print(dim(test_labels))
    
    return(df)
}

select_mean_std <- function(data_frame) {
    #subdf <- data_frame[ , grepl("mean()|std()|subject|activity", names(data_frame), fixed = F)]
    subdf <- data_frame[ , grepl("subject", names(data_frame), fixed = T) | grepl("activity", names(data_frame), fixed = T) | grepl("-mean()", names(data_frame), fixed = T) | grepl("-std()", names(data_frame), fixed = T) ]
    
    return(subdf)
}

calculate_average <- function(data) {
    df_colnames <- colnames(data)
    df_colnames <- df_colnames[3:length(df_colnames)]
    df_melt <- melt(data, id = c("subject", "activity"), measure.vars = df_colnames)
    subdf_melt_dcast <- dcast(df_melt, subject + activity ~ variable, mean)
    
    return(subdf_melt_dcast)
}