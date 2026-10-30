# E-Commerce Sales Performance Dashboard

An end-to-end data analytics project focused on analyzing transactional e-commerce data. This project involves structuring database schemas, executing advanced SQL queries for data extraction, and designing an interactive, insight-driven dashboard in Power BI to monitor key retail performance metrics.

## 📊 Project Overview
The goal of this project is to transform raw, unstructured transactional records into actionable business insights. By bridging the backend database structure with front-end visual reporting, this project enables stakeholders to track revenue growth, understand regional customer behavior, and evaluate product categories.

## 🛠️ Tech Stack & Tools
*   **Database Management:** SQL Server (SSMS)
*   **Data Querying Language:** Structured Query Language (SQL)
*   **Data Visualization & BI:** Power BI Desktop
*   **Data Preparation:** SQL Server(SSMS)

## 🗄️ Database Design & SQL Implementation
The project implements a relational database structure (RDBMS) optimized for analytical reporting. 

### Key SQL Operations Performed:
*   **Data Definition & Manipulation:** Structured tables using `DDL` (Data Definition Language) and populated/cleaned records using `DML` (Data Manipulation Language).
*   **Advanced Data Aggregation:** Used complex multi-table `JOINs`, `GROUP BY` statements, and subqueries to calculate total sales, profit margins, and order quantities.
*   **Time-Series Analysis:** Wrote window functions and date manipulation queries to extract Month-over-Month (MoM) and Year-over-Year (YoY) performance trends.

*(Optional: You can paste your core SQL query scripts inside the `scripts/` folder of this repository).*

## 📈 Power BI Dashboard Features
The extracted clean datasets were connected to Power BI to engineer a dynamic executive dashboard featuring:
*   **Sales Performance Overview:** KPI cards monitoring Total Revenue, Total Orders, Profit Margins, and Average Order Value (AOV).
*   **Product Insights:** Matrix tables and bar charts highlighting top-selling and underperforming product categories.
*   **Geographical Analysis:** Map visualizations tracking sales distribution across different operational zones and cities.
*   **Interactive Slicers:** Dynamic filters allowing users to drill down by Year, Quarter, Region, and Product Segment.

## 💡 Key Insights Delivered
1. Identified top-performing regions contributing to over 40% of total revenue.
2. Isolated seasonal sales spikes during specific quarters, enabling better inventory planning strategies.
3. Highlighted low-margin product categories that required price optimization adjustments.

## 📂 Repository Structure
```text
├── database/
│   └── ecommerce_schema.sql      # Database schema creation and sample datasets
├── SQL_Queries/
│   └── business_problems.sql     # SQL scripts answering key business metrics
├── dashboard/
│   └── Ecommerce_Sales.pbix      # Power BI dashboard file
└── README.md                     # Project documentation
```

## 🚀 How to Run this Project
1. Clone this repository to your local machine.
2. Execute the `.sql` scripts inside your SQL Server (SSMS) or MySQL Workbench to set up the database environment.
3. Open the `.pbix` file using **Power BI Desktop** to view and interact with the dynamic sales report.
