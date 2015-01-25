The process started off with setting the working directory .

Next is to read in the test datasets which consist of subject_test.txt, X_test.txt and Y_test.txt into a data frame. Also read in the features.txt which contain the headers for the X_test file as well as the activity_labels.txt which contain the description of each of the activity. The next step is to assign the right header information to each of the file that was read in. The final step is to combine all the test data frame into a single data frame by using the cbind function

Repeat the above process for the training dataset. Once the various training data frame is combine into a single data frame, the next step is to combine the test and train data frame into a single data frame using the rbind function.

The next step is to extract out all the attributes that have the word ???mean.??? and ???std.??? in the attribute name.  By this time, the data frame will contain only the subject, feature and the attributes that contain the word ???mean.??? and ???std.???.

Next, join the data frame to the activity label data frame using the feature as a common attribute. This will ensure that the description of the activity is added to each observation.

Next, group by the subject and activity label, perform the mean function on each column. This will result in a data frame that contain the subject, activity label and the mean of the other variables.

Remove the attribute ???feature??? as it is redundant. This information appear as the activity label in the data frame. Last but not least, write the result to a txt file.
