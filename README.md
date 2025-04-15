# Walmart Overview

Walmart Inc. is a leading American multinational retail corporation that operates a chain of hypermarkets, discount department stores, and grocery stores across the United States and internationally. Founded in 1962 by Sam Walton, Walmart has become one of the world’s largest companies by revenue, generating over **$670 billion in revenue** in 2024. Its mission is to "save people money so they can live better," and it achieves this through large-scale operations, supply chain efficiency, and aggressive pricing strategies. They also have a strong e-commerce presence and a diversified portfolio of services, including financial and health-related offerings.

Insights and recommendations are provided on the following key areas:
- **Store Performance Comparison:** An assessment of how different store types perform, identifying consistently high or low-performing formats to help inform future investment and resource allocation strategies.

- **Seasonality Time Series Analysis:** An evaluation of monthly and seasonal sales patterns to identify periods of consistent outperformance or underperformance relative to overall trends.

- **Store Size Impact:** An analysis of whether store size correlates with sales performance, and if there are specific thresholds where size contributes to revenue growth.

- **Weather & Sales:** A statistical analysis examining the relationship between temperature and sales, offering insights into whether weather conditions influence consumer purchasing behaviour.

- **Holiday Sales Performance:** A breakdown of holiday sales performance, pinpointing which holidays result in the highest sales and exploring the potential reasons behind those spikes.

Targeted SQL queries regarding various business questions are found [here](https://github.com/AdnanH901/Walmart_data_analysis/blob/main/SQL/walmart.sql).

The Tableau dashboards presenting insights in the key areas explored are found [here](https://github.com/AdnanH901/Walmart_data_analysis/tree/main/Tableau).

To quickly view the overview of findings and recommendations, click on [Overview of Findings](#overview-of-findings) and [Recommendations](#recommendations).

# Data Structure & Initial Checks
## ERD Diagram of Data

<img width="1011" alt="image" src="https://github.com/user-attachments/assets/321a1e30-5527-4cff-912e-adcfb6d027ca"/> 

## Summary of Data
Walmart's main database structure consists of three tables: features, sales and stores, with a total row count of **430,000**. A description of each table is as follows:
- **features:** It consists of weekly data from 45 different Walmart stores across the US between 2010 and 2012. It includes features such as the local temperature, fuel prices, CPI, unemployment rates, and whether the given week is a holiday.
- **sales:** Contains weekly sales data of each store over the years 2010-2012.
- **stores:** Contains the store type and the size of each store (encoded as type A, B and C).

# Executive Summary
### Overview of Findings
![image](https://github.com/user-attachments/assets/f8de23bf-ddbe-43ee-a85d-f637de54a949)

From 2010 to 2012, Walmart attained a monthly sales average of **600 million**. The majority, 48%, of stores are classified as *Type A* and contribute the most sales, accounting for 64% of sales overall and averaging **20,000** sales per store per month. Walmart performs much better during the hotter seasons, spring and summer, compared to the colder seasons, autumn and winter. Holidays, such as Christmas, are days that contribute to a large number of sales, with the corresponding week contributing around 10% to 20% of a given month's sales. January and November have performed the worst with sales numbers contributing only 5% and 6% respectively of sales overall.

# Insights Deep Dive
### **Store Size Impact**
<img width="1011" alt="image" src="https://github.com/user-attachments/assets/085f680f-f858-420f-b5c4-c472f40e8d8d"/> 

- **Type Differences:** Walmart's stores are decomposed into three types, encoded as *Type A*, *Type B* and *Type C*. Although not much information is given as to their differences, from the data, we can see that:
  - ***Type A* stores are the majority and are the biggest:** *Type A* stores are the account for **44%** of all Walmart stores and average around **175,000 square feet**. *Type B* stores make up **38%** of Walmart stores and average around **101,000 square feet**. *Type C* stores are the minority making up **18%** of Walmart stores and average around **41,000 square feet**. 
  - ***Type A* stores attain the highest sales numbers:** *Type A* stores are stores that typically achieve the highest sales numbers compared to the other types of stores, averaging **206 million sales** in total per store. *Type B* stores average around **117 million sales** in total per store closley followed by *Type C* stores averaging around **101 million sales** in total per store. *Type A* stores give nearly double the sales numbers of *Type B* and *Type C* stores. This shows how valuable *Type A* stores are and how essential they are to the sustainability and growth of Walmart's business. However, despite their size, *Type C* stores comfortably compete against *Type B* stores whilst being less than half as big. This is most likely because they fill a market in smaller communities and busy/ cramped areas.
- ***Type A & C* stores are the way to go:** The data suggests a positive correlation between size and sales numbers; in other words, <ins>***the bigger the size, the bigger the sales***</ins>. The data also clearly shows that smaller stores of *Type C* still generate relatively high sales numbers despite their size. This suggests that Walmart should invest in and build more *Type A* and *Type C* stores across the US and abroad.

### **Seasonality Time Series Analysis**  
![image](https://github.com/user-attachments/assets/4482e694-1eaf-4ca7-939c-04a4d7909fb5)

- **Monthly Time Series Analysis:** Walmart experiences a high jump in sales from January, which is at its lowest at around **325 million**, to February, increasing by around **300 million**. Walmart's sales then undergo steady gains till April, where it experiences its first peak. Following April, Walmart experiences a minute dip in sales before steadily increasing till it reaches its second and highest peak in July. After that, the remaining months float above **550 million** sales, except for November at around **400 million** sales.
- **Seasonal Analysis:** It is clear that Walmart does much better during the warmer seasons than the colder seasons. In the colder seasons, Walmart procured **3.1 billion** sales across the three years and in the warmer seasons, Walmart has procured **3.7 billion** sales over three years. This suggests that people buy more items in the hotter climates than the colder climates, possibly due to summer holidays.

### **Holiday Sales Performance**
<img width="1011" alt="image" src="https://github.com/user-attachments/assets/9bd5a02b-31a3-4094-975c-1032fbdc1526"/> 

### Temperature & Sales
<img width="560" alt="image" src="https://github.com/user-attachments/assets/532665b2-9c89-4093-9101-5294cee5a2c9"/> 
<img width="447" alt="image" src="https://github.com/user-attachments/assets/036db379-a197-4a1b-ad93-0794819e43bd"/> 

- **Temperature Rundown:** The graph on the right presents the sales and the 





