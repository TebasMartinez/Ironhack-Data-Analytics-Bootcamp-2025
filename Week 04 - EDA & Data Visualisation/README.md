# Week 4 - EDA & Data Visualisation

## Lab repos:
- [EDA Univariate Analysis](https://github.com/TebasMartinez/lab-eda-univariate)
- [EDA Bivariate Analysis](https://github.com/TebasMartinez/lab-eda-bivariate)
- [Tableau](https://github.com/TebasMartinez/lab-tableau)
- [Tableau Advanced](https://github.com/TebasMartinez/lab-tableau-advanced)
- [Intro to BI and Tableau](https://github.com/TebasMartinez/lab-intro-to-bi-and-tableau)
- [Mini Project - BI: Data to Viz](https://github.com/TebasMartinez/mini-project-bi-data-to-viz) 

## Notes:

### Statistics
- Descriptive statistics simply describe the sample.
- Inferential statistics aim to understand the whole population based on the sample.

- An individual is a member of the population, a whole row.
- A variable is a specific characteristic or attribute, columns.


### Boxplot whisker/ouliers calculation
Difference between Q3 and Q1 is the Interquartial range (IQR). To calculate the upper and lower whiskers in the box:
````
Uw = Q3 + 1,5 IQR
````
````
Lw = Q1 - 1,5 IQR
````

(The 1,5 can be changed) \
One way of handling outliers is filtering out everything above the Upper whisker.  \
It's a very simple approach of handling outliers, during DA we can use more precise methods.


### P-value
The probability of seen this data, assuming the null hypothesis is true.
"Assuming that your assumption is true, how likely are you to see this data?"
A value providing a measure that helps determine if the observed data deviates from my assumptions/hypothesis.
- If p-value < 0.05, disproof the null hypothesis: the observed data significantly differs from the expectation that the variables are independent, you have enough evidence against the assumption (so the variables are more likely correlated).
- If p-value >= 0.05, the observed data doesn't deviate much from the expectation that the variables are independed (so the variables are less likely correlated).

### Tableau
- Dimensions: categorical variables.
- Measures: numerical variables.