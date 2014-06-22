## Study Design

A detailed description of the original activity measurement study design can be found in the `README.txt` file of the `data/UCI HAR Dataset` directory. For this analysis the data was downloaded from the following address:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  

Beginning with the compressed (`.zip`) file, the data was loaded into `R` for subsequent cleaning and summarizing.

## Tidy Data Variables

The cleaned data set found in `data/tidy/uciHarClean.txt` contains 79 variables summarizing either accelerometer or gyroscope measurements for subjects and activities. The other two variables, `subject` and `activity` are (1) labels corresponding to the volunteer being measured ([1-30]) and (2) descriptions of the physical activity being performed. Activities include:
+ laying
+ sitting
+ standing
+ walking
+ wakling_downstairs
+ walking upstairs

Each of the 79 signal measurement variables includes several components with following meanings(symbols in [brackets] indicate corresponding label from the original raw data set):

##### time/freq
+ **time [t]:** measurement is in the time domain
+ **freq [f]:** measurement is in the frequency domain following Fast Fourier Transform (FFT)  

##### Body/Gravity
+ **Body [Body]:** body acceleration signal
+ **Gravity [Gravity]:** gravity acceleration signal

##### Acceleration/AngularVelocity
+ **Acceleration [Acc]:** sensor signal from accelerometer
+ **AngularVelocity [Gyro]:** sensor signal from gyroscope

##### Jerk/Magnitude
+ **Jerk [Jerk]:** Jerk signals obtained from deriving body acceleration/angular velocity in time
+ **Magnitude [Mag]:** magnitude of any 3-D signal obtained using the Euclidean norm

##### mean()/std()/meanFreq()
+ **mean() [mean()]:** average of measurements across time windows
+ **std() [std()]:** standard deviation of measurements across time windows
+ **meanFreq() [meanFreq():]**: weighted average of the frequency components to obtain a mean frequency

##### X/Y/Z
+ **X/Y/Z [X/Y/Z]:** directional component of 3-D signal

*Note: all variables are normalized and bounded within [-1, 1]*

Per the instructions of the assignment, only variables corresponding to mean() or std() measurements were kept. Thus, the following additional measurements included in the raw data were excluded:
+ mad()  
+ max()  
+ min()  
+ sma()  
+ energy()  
+ iqr()  
+ entropy()  
+ arCoeff()  
+ correlation()   
+ maxInds()  
+ skewness()  
+ kurtosis()  
+ bandsEnergy()  
+ angle()  

For full descriptions of all features included in the original data set, refer to the **Raw Data Variables** section below.


## Data Processing and Summary

All steps for data processing were performed using `run_analysis.R`. The script was used to first merge data for training and test samples, extract variables of interest for mean and standard deviation measurements, and format/clean up data labels and description. Finally, the remaining variables described above were summarized by taking the average across observations for each subject and activity. The final data set was saved to `uciHarClean.txt` under the `data\tidy` directory.

All steps of the analysis were carried out using the `run_analysis.R` script. The script relies primarily on (1) built in `R` functions for reading in data and working with data frames; (2) the `grep()` and `gsub()` functions for identifying or manipulating strings based on regular expressions; and (3) data frame subsetting/summarizing functions from Hadley Wickham's `dplyr` package. Further detail and description of **all individual steps** can be found in the comments within `run_analysis.R`.


## Raw Data Variables 

*The description below is copied from the `features_info.txt` file under the raw data directory `data/UCI HAR Dataset`.*

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.  
iqr(): Interquartile range  
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal  
kurtosis(): kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in `features.txt`.

