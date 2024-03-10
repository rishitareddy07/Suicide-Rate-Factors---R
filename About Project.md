# Project Description

## Goal
Analyse Factors Affecting Suicide in USA

## Executive Summary

Suicide is a major public health concern in the United States (US), affecting individuals across age groups, resulting in severe and prolonged effects on families and communities. In fact, currently it is the 12th leading cause of death in the United States. In 2020, 45,979 Americans died by committing suicide, among those roughly 4 times were men as compared to women. That averages roughly 130 suicides per day. The WHO and the US Surgeon General highlighted the need for more comprehensive data on the occurrence of suicidal thoughts and attempts, for planning national health care policy to reduce suicide-related behaviors.  

To understand what contributes the most to suicide ideation or attempts, our project attempts to find the causes and factors that are most responsible for the same. After our analysis, we also attempt to provide some recommendations considering the factors, to find some solution to this problem.

For our analysis, we referred to a lot of prior research as well as considered various data sources. We were able to narrow down some factors that were most common. The features included age, mental health, gun access, economic factors, and so on. We used various data sources such as the CDCs Wonder database, The Bureau of Labor Statistics data for economic factors, as well as a propriety gun friendly index [7] to understand gun laws strictness in a state.

In our analysis we found that the white men were disproportionately affected by suicides as well as the senior population of the United States. We provide a systematic analysis of our process and provide recommendations to Government or Non-Profit organizations to reduce suicide attempts.

## Problem Statement and Significance

Suicide is one of the leading causes of death worldwide. Suicide is an act of self-harm by an individual to end his/her life. The problem with this crisis is that it is not caused by just one factor, but a myriad and complex factors ranging from individual experiences with bullying, mental distress up to societal factors such as unemployment, race & ethnicity factors, etc. Also, suicide affects across age groups, hence the studying the causes becomes far more complex.

Suicide has far reached impacts to not just the individuals but to their loved ones including family and society. Suicide of an individual causes a chain effect of mental distresses among the people that individual connected with during their life. These mental distress factors can trigger suicide ideations in others as well.

The financial toll of suicide on society is also costly, according to the CDC [8]. In 2019, suicide and nonfatal self-harm cost the nation nearly $490 billion in medical costs, work loss costs, value of statistical life, and quality of life costs.

Hence it is a very important crisis to solve in today's modern society. Suicide is not a random phenomenon; it occurs due to several factors in the due course of time in an individual's life. Thus, it is a very preventable crisis, if we provide interventions during the suicide ideation stage and provide better mental health service to those that are affected by it. States and communities can use the Prevention Resource to help make decisions about suicide prevention activities. Strategies range from those designed to support people at increased risk to a focus on the whole population, regardless of risk 

## Prior Literature

There is a lot of research in this area. Some of the prior literatures are mentioned below:

Reeves, Stuckler (2012) [1] stated that economic depression or recession is one of the leading causes of suicide rate. Their paper highlights that there was an increase in suicide mortality rate due to the onset of the crisis from 1999 to 2007. As unemployment increases, so do the suicides and this could be observed in the 2007-10 period due to the financial crisis of 2008.

Compton, Druss (2021) [2] highlighted how suicide rates increase more rapidly in rural areas compared to urban areas. They also attributed lack of mental health treatment as one of the leading causes for the increase in suicide rate. In fact, the counties that were classified as mental health shortage areas (HPSAs), experienced a rise in suicide rates compared to non HPSAs.

The research by Kessler, Borges [3] tried to understand suicide ideation. They used a total of 9282 interviews that were conducted in which respondents were asked questions related to suicide ideation/attempts or gesture. The data were then examined for the associations of suicide related behaviors with mental disorders using WHO Composite International Diagnostic Interview (CIDI) and the Diagnostic and Statistical Manual of Mental Disorders (DSM-III and DSM-IV).  The associations were analyzed using sociodemographic variables: age, sex, race/ethnicity, education, marital status, employment status, and region of the country.

As mentioned in the paper Understanding Suicide Across the Lifespan [4], Suicidal ideation risk factors broadly falls under two categories: Static risk factors and Dynamic risk factors. Static risk factors are stable/fixed attributes, which imbue a baseline risk; they include sex, race, age, sexual orientation, family history, and personal history of suicide attempts.  Dynamic factors fluctuate throughout an individual's life; they include symptoms of mental illness, substance use, firearm possession, and access to healthcare.

Access to guns was also considered a most important factor in suicide deaths. Pritchard C, Hansen [5] described one feature that might be considered cultural’ in the USA compared to Other Western Countries is the easy access to firearms, where in most US States eighteen-year-olds can purchase firearms. This despite evidence that more than 50% of suicides in America are gun-related and children’s suicides are often the result of using the parent’s weapons. 

Similarly, Martinez, Hernandez, Khaul [6] stated that firearm suicide is the most common method of suicide in the United States, accounting for one in two suicides among males and one in three among females, suicides would be expected to closely relate to access to firearms. However, even though this suicide method represents a plurality of suicide deaths in the United States, recent data suggest that firearm ownership is decreasing, rather than increasing, in the United States

## Data Source and Preparation

https://wonder.cdc.gov/
WONDER online databases utilize a rich ad-hoc query system for the analysis of public health data.	Filtered the data based on all the causes of deaths which are mapped to suicide, and group by State, year, race, age group from year 2005 to year 2020.
https://www.bls.gov/
The Bureau of Labor Statistics measures labor market activity, working conditions, price changes, and productivity in the U.S. economy to support public and private decision making.	Few Variable data such as CPI is collected from database. Variables such as unemployment, minimum wage, mortgage rate, income tax are collected from multiple files and merged
 https://www.az-defenders.com/best-states-for-gun-owners/
Ranked all states in a proprietary Gun Friendly Index, calculated by assigning scores to multiple parameters and weighing them based on importance to gun owners. At the end, this was then weighted based on the overall culture and sentiment toward firearms in the state.	Collected the score of each state from published report.

## Data Structure

●	Records 17, 898 for years 2005 -2020
●	14 important variables to consider include: 
○	State
○	Year	
○	Age Group
○	Race
○	Urbanization
○	Population
○	Unemployment Rate
○	Income Tax
○	Mortgage Rate
○	Minimum Wage
○	Consumer Price Index
○	Mental Health Shortage
○	Gun Rule Ranking
○	Divorce rate
○	Suicide rate

## Feature Engineering

Some possible feature engineering we may have to do based on Prior Work research
-	Consolidated urbanization areas to 2 types such as Urban/Rural
-	Factorized all categorical variables.
-	Merged all the data for each variable by state and year.
-	Dropped the unwanted variables.
-	From different income slabs, only the tax rate for income around USD20,000 or greater than USD 10000 are considered assuming low income leads to suicide.
-	The mean of unemployment rate and minimum wage of each state for any year is calculated and used.
-	Suicide rate is calculated per million people for each state.

## Insights and Recommendations

### Insights:
•	American Indian or Alaska Natives have highest risk of suicide. They have 15% more chance of suicide than White Americans and 22% more chance than Black or Asian people. 

•	People of age 85+ are at highest risk of suicide death.
•	People in rural area are at more risk of suicide death than urban area people.


### Recommendation:
•	State gun laws seem to affect access, which in turn is a known factor for most suicides. Hence, stricter gun laws (based on background checks, etc.) could limit access and hence could prevent suicide attempts by non-eligible gun owners. 

•	Mental health is a contributing factor, hence increasing diagnostic services as well as support services could decrease suicides due to mental health issues such as depression, PTSD, etc.

## References

[1]. Reeves, A., Stuckler, D., McKee, M., Gunnell, D., Chang, S. S., & Basu, S. (2012). Increase in state suicide rates in the USA during economic recession. The Lancet, 380(9856), 1813-1814.
[2]. Ku, B. S., Li, J., Lally, C., Compton, M. T., & Druss, B. G. (2021). Associations between mental health shortage areas and county-level suicide rates among adults aged 25 and older in the USA, 2010 to 2018. General hospital psychiatry, 70, 44-50.
[3]. Kessler RC, Berglund P, Borges G, Nock M, Wang PS. Trends in Suicide Ideation, Plans, Gestures, and Attempts in the United States, 1990-1992 to 2001-2003. JAMA. 2005;293(20):2487–2495. 
[4]. Ian H. Steele M.D.,Natasha Thrower M.D.,Paul Noroian M.D.,Fabian M. Saleh M.D. Understanding Suicide Across the Lifespan: A United States Perspective of Suicide Risk Factors, Assessment & Management
[5]. Pritchard C, Hansen L, Dray R, Sharif J. USA Suicides Compared to Other Western Countries in the 21st Century: Is there a Relationship with Gun Ownership? Arch Suicide Res. 2022 Jan 24:1-13. doi: 10.1080/13811118.2021.1974624. Epub ahead of print. PMID: 35068366.
[6]. Martinez-Ales G, Hernandez-Calle D, Khauli N, Keyes KM. Why Are Suicide Rates Increasing in the United States? Towards a Multilevel Reimagination of Suicide Prevention. Curr Top Behav Neurosci. 2020; 46:1-23. doi: 10.1007/7854_2020_158. PMID: 32860592; PMCID: PMC8699163.
[7]. “Gun Laws by State: Best States for Gun Owners (2022).” AZ Defenders, 2 Feb. 2022, https://www.az-defenders.com/best-states-for-gun-owners/. “Gun Laws by State: Best States for Gun Owners (2022).” AZ Defenders, 2 Feb. 2022, https://www.az-defenders.com/best-states-for-gun-owners/.
[8]. "Facts About Suicide | Suicide | CDC." https://www.cdc.gov/suicide/facts/index.html, Accessed 29 Oct. 2022.


