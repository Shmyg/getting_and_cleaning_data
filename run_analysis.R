## Initialization

# Reading feature names
features <- read.table("data/features.txt")
# Creating a name vector to be used later for column names in dataset
feature_names <- c(as.character(features[,2]))
# Reading data; column names are assigned with the data from previous step
data <- read.table("data/train/X_train.txt", col.names=feature_names, stringsAsFactors=FALSE)
test_data <- read.table("data/test/X_test.txt", col.names=feature_names, stringsAsFactors=FALSE)
# Merging test and main data
complete_data <- rbind (data, test_data)
# Reading labels, here we can assign a name to the single column immediately
labels <- read.table("data/train/y_train.txt", col.names=c("label"), stringsAsFactors=FALSE)
test_labels <- read.table("data/test/y_test.txt", col.names=c("label"), stringsAsFactors=FALSE)
# Merging test and main labels
complete_labels <- rbind (labels, test_labels)
# Reading activity names
act_labels <- read.table("data/activity_labels.txt", col.names=c("label_id","label_name"), stringsAsFactors=FALSE)
# Reading subjects
subjects <- read.table("data/train/subject_train.txt", col.names=c("subject"), stringsAsFactors=FALSE)
test_subjects <- read.table("data/test/subject_test.txt", col.names=c("subject"), stringsAsFactors=FALSE)
# Merging test and main subjects
complete_subjects <- rbind (subjects, test_subjects)


## Main section

# Function to return activity name
act_name <- function (x) {
df <- subset(act_labels, label_id  == x)
return (df$label_name)
}

# Replacing activity ID with activity name
for (i in 1:(nrow(complete_labels))) {
complete_labels[i, 1] <- act_name (complete_labels[i,1])
}

# Creating vector with column names to extract from the dataset
names <- colnames (data)
filtered_names <- names[grep ("[M|m]ean|std", names)]

# Extracting necessary columns
filtered_data <- complete_data[,filtered_names]

# Putting all together with subjects and activity labels
final_data <- cbind (complete_subjects, complete_labels, filtered_data)

# Applying aggreation, removing unnecessary columns and renaming grouping columns
result <- aggregate(final_data, by=list(final_data$subject, final_data$label), mean)
final_result <- result[, !names(result) %in% c('subject', 'label')]
names(final_result)[names(final_result)=="Group.1"] <- "Subject"
names(final_result)[names(final_result)=="Group.2"] <- "Activity"

# Voila
write.table (final_result, "tidy_data.txt", row.name=FALSE)
