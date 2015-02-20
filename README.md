# Getting and cleaning data - course project

The project contains a single executable R file and data directory.

Workflow of the file:
1.  Initialization section: reading feature names, subjects, activity names and labels
from both test and main directory. Test data is appended to the main one.
2. Main section
* Replacing activity labels (e.g. IDs) with the corresponding names to make it
human-readable 
* Creating vector with column names to extract from the dataset; we need here
only 'mean' and 'std' columns. 'm' can be either uppercase or lowercase, so
should be considered while looking for columns.
* Extracting necessary columns based on the created vector.
* Merging the data itself with subjects and activity names.
* Applying aggreation, removing unnecessary columns ('label' and 'subject' are
not needed anymore) and renaming grouping columns to human-readable
* Creating the file
