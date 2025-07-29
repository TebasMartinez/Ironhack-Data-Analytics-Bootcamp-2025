# Week 4 - EDA & Data Visualisation

## Lab repos:


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
It's a very simple approach of handling outliers, during DA we can use more precise methods.

### P-value
"Assuming that your assumption is true, how likely are you to see this data?"
A value providing a measure that helps determine if the observed data deviates from my assumptions/hypothesis.
- If p-value < 0.05, the observed data significantly differs from the expectation that the variables are independent, you have enough evidence against the assumption (so the variables are more likely correlated).
- If p-value >= 0.05, the observed data doesn't deviate much from the expectation that the variables are independed (so the variables are less likely correlated).


