# Walmart Overview

Walmart Inc. is a leading American multinational retail corporation that operates a chain of hypermarkets, discount department stores, and grocery stores across the United States and internationally. Founded in 1962 by Sam Walton, Walmart has become one of the world’s largest companies by revenue, generating over **$670 billion in revenue** in 2024. Its mission is to "save people money so they can live better," and it achieves this through large-scale operations, supply chain efficiency, and aggressive pricing strategies. They also have a strong e-commerce presence and a diversified portfolio of services, including financial and health-related offerings.

Insights and recommendations are provided on the following key areas:
- **Store Performance Comparison:** An assessment of how different store types perform, identifying consistently high or low-performing formats to help inform future investment and resource allocation strategies.

- **Seasonality Time Series Analysis:** An evaluation of monthly and seasonal sales patterns to identify periods of consistent outperformance or underperformance relative to overall trends.

- **Store Size Impact:** An analysis of whether store size correlates with sales performance, and if there are specific thresholds where size contributes to revenue growth.

- **Weather & Sales:** A statistical analysis examining the relationship between temperature and sales, offering insights into whether weather conditions influence consumer purchasing behaviour.

## Key Deliverables and Navigational Links

Targeted SQL queries regarding various business questions are found [here](https://github.com/AdnanH901/Walmart_data_analysis/blob/main/SQL/walmart.sql).

The Tableau dashboards presenting insights in the key areas explored are found [here](https://github.com/AdnanH901/Walmart_data_analysis/tree/main/Tableau).

To quickly view the overview of findings and recommendations, click on [Overview of Findings](#overview-of-findings) and [Recommendations](#recommendations).

# Data Structure & Initial Checks
## ERD Diagram of Data

<img width="1011" alt="image" src="https://github.com/user-attachments/assets/321a1e30-5527-4cff-912e-adcfb6d027ca"/> 

## Summary of Data
Walmart's main database structure consists of three tables: features, sales and stores, with a total row count of **430,000**. A description of each table is as follows:
- **features:** It consists of weekly data from 45 different Walmart stores across the US between 2010 and 2012. It includes the local temperature, fuel prices, CPI, unemployment rates, and whether the given week is a holiday.
- **sales:** Contains weekly sales data of each store over the years 2010-2012.
- **stores:** Contains the store type and the size of each store (encoded as type A, B and C).

# Executive Summary

## Overview of Findings
![image](https://github.com/user-attachments/assets/f8de23bf-ddbe-43ee-a85d-f637de54a949)
<br><br>

From 2010 to 2012, Walmart attained a monthly sales average of **600 million**. The majority, 48%, of stores are classified as *Type A* and contribute the most sales, accounting for 64% of sales overall and averaging **20,000** sales per store per month. Walmart performs much better during the hotter seasons, spring and summer, compared to the colder seasons, autumn and winter. Holidays, such as Christmas, contribute to many sales, with the corresponding week contributing around 10% to 20% of a given month's sales. January and November have performed the worst with sales numbers contributing only 5% and 6% respectively.

# Insights Deep Dive

## **Store Size Impact**
<img width="1011" alt="image" src="https://github.com/user-attachments/assets/085f680f-f858-420f-b5c4-c472f40e8d8d"/> 
<br><br>

- **Type Differences:** Walmart's stores are decomposed into three types, encoded as *Type A*, *Type B* and *Type C*. Although not much information is given as to their differences, from the data, we can see that:
  - ***Type A* stores are the majority and are the biggest:** *Type A* stores are the account for **44%** of all Walmart stores and average around **175,000 square feet**. *Type B* stores make up **38%** of Walmart stores and average around **101,000 square feet**. *Type C* stores are the minority making up **18%** of Walmart stores and average around **41,000 square feet**. 
  - ***Type A* stores attain the highest sales numbers:** *Type A* stores typically achieve the highest sales numbers compared to the other types of stores, averaging **206 million sales** in total per store. *Type B* stores average around **117 million sales** in total per store closley followed by *Type C* stores averaging around **101 million sales** in total per store. *Type A* stores give nearly double the sales numbers of *Type B* and *Type C* stores. This shows how valuable *Type A* stores are and how essential they are to the sustainability and growth of Walmart's business. However, despite their size, *Type C* stores comfortably compete against *Type B* stores whilst being less than half as big. This is most likely because they fill a market in smaller communities and busy/ cramped areas.
- ***Type A & C* stores are the way to go:** The data suggests a positive correlation between size and sales numbers; in other words, <ins> ***the bigger the size, the bigger the sales***</ins>. The data also clearly shows that smaller stores of *Type C* still generate relatively high sales numbers despite their size. This suggests that Walmart should invest in and build more *Type A* and *Type C* stores across the US and abroad.

## **Seasonality Time Series Analysis**  
![image](https://github.com/user-attachments/assets/4482e694-1eaf-4ca7-939c-04a4d7909fb5)

- **Monthly Time Series Analysis:** Walmart experiences a high jump in sales from January, which is at its lowest at around **325 million**, to February, increasing by around **300 million**. Walmart's sales then undergo steady gains till April, where it experiences its first peak. Following April, Walmart experiences a minute dip in sales before steadily increasing till it reaches its second and highest peak in July. After that, the remaining months float above **550 million** sales, except for November at around **400 million** sales.
- **Seasonal Analysis:** It is clear that Walmart does much better during the warmer seasons than the colder seasons. In the colder seasons, Walmart procured **3.1 billion** sales across the three years and in the warmer seasons, Walmart has procured **3.7 billion** sales over three years. This suggests that <ins>***people buy more items in the hotter climates than the colder climates***</ins>, possibly due to summer holidays.

## Temperature & Sales
<img width="560" alt="image" src="https://github.com/user-attachments/assets/532665b2-9c89-4093-9101-5294cee5a2c9"/> 
<img width="447" alt="image" src="https://github.com/user-attachments/assets/f17f47ed-4d2a-4d65-8441-9fe90e660da6"/> 
<br><br>

- **Peak Sales at 0°C:** The graph on the right presents the average weekly sales for an average weekly temperature, and the graph on the left shows the average monthly temperatures across the US. The graph on the right starts with a huge dip towards the colder extreme temperatures before steadily increasing until **0°C**, where the sales peak. Sales numbers then fluctuate between **30,000** and **55,000** for temperatures above **0°C** before experiencing another huge dip at the hotter extreme temperatures.
- **Temperature Data Seemingly Contradicts Intuition & Results:** Intuitively, from the analysis shown in [Seasonality Time Series Analysis](#seasonality-time-series-analysis), one would expect Walmart's sales in the more extreme sides to be greater than other temperatures and for warmer temperatures to display higher sales numbers overall compared to lower temperatures. Furthermore, Walmart's Sales peaking at 0°C contradicts the statements made in [Seasonality Time Series Analysis](#seasonality-time-series-analysis). At first glance, the data regarding temperature seems to contradict the narrative that hotter climates lead to greater sales. However, the graph on the left shows that colder temperatures (especially around 0°C) are the modal temperatures, which explains the peak on the right graph. Overall, the data suggests that Walmart's greater success in hotter climates is due to factors besides temperature; in other words, <ins>***temperature is no direct indication of high sales***</ins>.

# Recommendations:

Based on the insights and findings above, we would recommend that the Store Development, Strategic Planning, Marketing, and Supply Chain teams consider the following:

- **Early-Year Promotions:** Focus on strong promotional activities from January to April to capitalise on the natural sales increase.
  
- **Holiday Focus:** Enhance holiday marketing campaigns in December to boost sales further, leveraging the slight recovery seen after the November dip.

- **Inventory Planning:** Walmart should focus on ramping up inventory before peak sales periods like April and maintain a steady supply during the mid-year months to prevent stockouts.

- **Sustain Mid-Year Sales:** Maintain consistent inventory and targeted marketing during May to August to sustain the steady demand. 
  
- **Promotional Strategies:** Targeted promotions during the January-April growth period and the mid-year stable period can maximise sales, while strategic discounts in November could help mitigate the sales dip.

- **Prioritise investment in *Type A* and *Type C* stores & avoid overinvesting in Type B stores:** The data suggests *Type A* and *Type C* stores show the highest returns relative to their size and market. Type A stores generate the most revenue, while Type C stores perform efficiently in compact or niche markets.

- **Possible Store Type Changes:** Initiate comprehensive strategic planning efforts to successfully transform stores of _Type B_ into high-performing _Type A_ locations.

- **Reassess overall strategies during January and November:** From [Seasonality Time Series Analysis](#seasonality-time-series-analysis), we know that January and November are Walmart's worst-performing months. Further analysis and more data need to be collected and evaluated to generate new possible promotions and sponsorships to inflate the sales during those months. For example, Walmart can increase stock levels in high-performing months (April to July) and optimise resources in slower months (January, November).

- **More data needed for further analysis:** There are many confounding variables that are easy to record, but are missing. For example, the qualities that differentiate each type of store, daily sales as opposed to weekly sales, the locations of each store, individual transaction histories of hundreds of stores, etc. This will allow for lower levels of analysis to be performed, thus allowing more granular insights and targeted strategic decisions.

- **Leverage holiday sales patterns** Focus on key holidays that significantly drive sales and tailor messaging and offers around consumer behaviour during these times.

- **Avoid relying solely on temperature trends:** Since temperature does not directly correlate with sales performance, campaigns should focus on other seasonal and behavioural cues instead.

- **Align campaigns with seasonal peaks:** Push more aggressive promotions during spring and summer when customers are more active.

- **Decouple weather from inventory forecasting:** Since sales do not directly correlate with temperature, weather data alone should not guide inventory decisions.

- 

# Assumptions and Caveats:

Throughout the analysis, multiple assumptions and caveats were made to manage challenges with the data. These assumptions and caveats are noted below.

## Assumptions
- **Assumption 1:** The data was drawn from [Kaggle](https://www.kaggle.com/), view the data [here](https://www.kaggle.com/datasets/aslanahmedov/walmart-sales-forecast), and is assumed to be an accurate depiction of Walmart's sales data.

- **Assumption 2:** The **45 stores** mentioned is a realistic localised depiction of the more than **10,750 store** that Walmart actually has.

- **Assumption 3:** Except for major holidays, the sales per day for a given week are distributed evenly, i.e.
```math
$$Daily\_Sales = \frac{Weekly\_Sales}{7}.$$
```

## Caveats

- **Caveat 1:** There are many confounding variables at play, especially regarding store type, temperature, CPI and unemployment rates. For example, the data does not show or define any explicit differences between types *A*, *B* and *C*, which leads us to only give high-level analysis on the advantages and drawbacks of each type. From the analysis in [Store Size Impact](#store-size-impact), the data suggests that store types *A* and *C* are objectively better than *B*. However, confounding variables may suggest that stores categorised as *Type B* may provide services/ access markets that the other types cannot, due to their nature.

- **Caveat 2:** There was a limited number of stores that were analysed, ideally, hundreds of stores' sales would be used for analysis.

- **Caveat 3:** Daily records of a store would be used for analysis compared to weekly records. Or even better, the daily transactions would be segmented into different groups for further analysis on possible deal bundles, discounts, etc.

