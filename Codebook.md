# Code Book 
This code book describes variables, data, and transformations or work  performed to clean up the data. The transformation steps resulted in the clean & tidy dataset [tidy_data.csv] (https://github.com/faroukbadawy/GettingAndCleaningData/edit/master/tidy_data.csv)

## Data Source
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Used Files
After downloading and extracting the dataset, only few files are relavent to the assignment requirements. This is the list of files used and a brief description:
- features.txt : List of all features.
- activity_labels.txt : Links the class labels with their activity name.
- train/X_train.txt : Training set.
- train/Y_train.txt : Training labels.
- test/X_test.txt : Test set.
- test/Y_test.txt : Test labels.
- train/subject_train.txt : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- train/subject_test.txt : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Processing Steps
1. Download dataset using function "download_dataset"
2. Extract dataset using function "extract_dataset"
3. Import and merge the training & test datasets to form one new dataset. Function "import_dataset" returns the merged dataset.
4. Select only the mean and standard deviation variables. Function "select_mean_std" takes the merged datset as input and returns the filtered dataset.
5. Calculate the avarage of each signals for each seubject and activity. Result dataset is stored as tidy_data.csv.
