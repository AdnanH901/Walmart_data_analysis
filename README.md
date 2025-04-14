# Walmart Overview

Walmart Inc. is a leading American multinational retail corporation that operates a chain of hypermarkets, discount department stores, and grocery stores across the United States and internationally. Founded in 1962 by Sam Walton, Walmart has become one of the world’s largest companies by revenue, generating over **$670 billion in revenue** in 2024. Its mission is to "save people money so they can live better," and it achieves this through large-scale operations, supply chain efficiency, and aggressive pricing strategies. They also have a strong e-commerce presence and a diversified portfolio of services, including financial and health-related offerings.

Insights and recommendations are provided on the following key areas:
- **Store Performance Comparison:** An assessment of how different store types perform, identifying consistently high or low-performing formats to help inform future investment and resource allocation strategies.

- **Seasonality Time Series Analysis:** An evaluation of monthly and seasonal sales patterns to identify periods of consistent outperformance or underperformance relative to overall trends.

- **Store Size Impact:** An analysis of whether store size correlates with sales performance, and if there are specific thresholds where size contributes to revenue growth.

- **Weather Correlation:** A statistical analysis examining the relationship between temperature and sales, offering insights into whether weather conditions influence consumer purchasing behavior.

- **Holiday Sales Performance:** A breakdown of holiday sales performance, pinpointing which holidays result in the highest sales and exploring the potential reasons behind those spikes.

Targeted SQL queries regarding various business questions are found [here](https://github.com/AdnanH901/Walmart_data_analysis/blob/main/SQL/walmart.sql).

The Tableau dashboards presenting insights in the key areas explored are found [here](https://github.com/AdnanH901/Walmart_data_analysis/tree/main/Tableau).

# Data Structure & Initial Checks
## ERD Diagram of Data

![table_relationships](https://github.com/user-attachments/assets/01b6b662-c2cd-4b66-9a28-769482d803c0)

## Summary of Data
Walmart's main database structure consists of three tables: features, sales and stores, with a total row count of **430,000**. A description of each table is as follows:
- **features:** It consists of weekly data from 49 different Walmart stores across the US between 2010 and 2012. It includes features such as the local temperature, fuel prices, CPI, unemployment rates, and whether the given week is a holiday.
- **sales:** Contains weekly sales data of each store over the years 2010-2012.
- **stores:** Contains the store type and the size of each store (encoded as type A, B and C).

# Executive Summary
## Overview of Findings
![image](https://github.com/user-attachments/assets/f8de23bf-ddbe-43ee-a85d-f637de54a949)


From 2010 to 2012, Walmart attained a monthly sales average of **600 million**. Stores classified as *Type A*, which is **64%** of them, contribute the most sales, averaging **20,000** sales per store. Walmart performs much better during the hotter seasons, spring and summer, compared to the colder seasons, autumn and winter. Holidays, such as Christmas, are days that contribute to a large number of sales, with the corresponding week contributing around 10% to 20% of a given month's sales. January and November have performed the worst with sales numbers contributing only 5% and 6% respectively of sales overall.

# Insights Deep Dive
## **Seasonality Time Series Analysis**  
- **Monthly Time Series Analysis:** Walmart experiences a high jump in sales from January, which is at its lowest at around **325 million**, to February, increasing by around **300 million**. Walmart's sales then undergo steady gains till April, where it experiences its first peak. Following April, Walmart experiences a small dip in sales before steadily increasing till it reaches its second and highest peak in July. After that, the remaining months float above **550 million** sales, except for November at around **400 million** sales.
- **Seasonal Analysis:** It is clear that Walmart does much better during the warmer seasons than the colder seasons. In the colder seasons, Walmart procured **3.1 billion** sales across the three years and in the warmer seasons, Walmart has procured **3.7 billion** sales over three years. This suggests that people buy more items in the hotter climates than the colder climates, possibly due to summer holidays.



