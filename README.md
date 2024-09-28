# AdventureWorks SQL Queries

<!-- PROJECT SHIELD -->
![License](https://img.shields.io/badge/license-MIT-green)

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">AdventureWorks SQL Queries</h3>

  <p align="center">
    A collection of SQL queries to analyze and extract insights from the AdventureWorks database!
    <br />
    <a href="#usage"><strong>Explore the queries »</strong></a>
    <br />
    <br />
    <a href="https://github.com/KosyEzenwaji/AdventureWorks-SQL-Queries">View Demo</a>
    ·
    <a href="https://github.com/KosyEzenwaji/AdventureWorks-SQL-Queries/issues">Report Bug</a>
    ·
    <a href="https://github.com/KosyEzenwaji/AdventureWorks-SQL-Queries/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

- [About the Project](#about-the-project)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [License](#license)
- [Contact](#contact)

<!-- ABOUT THE PROJECT -->
## About The Project

This project showcases a set of SQL queries designed for the **AdventureWorks** sample database. The queries cover common business cases such as product segmentation, employee analysis, and sales performance, and are a practical demonstration of various SQL techniques like `JOINs`, `CASE` statements, window functions, and custom views.

### Built With

* [Microsoft SQL Server (MSSQL)](https://www.microsoft.com/en-us/sql-server)
* [AdventureWorks Database](https://docs.microsoft.com/en-us/sql/samples/adventureworks)
* [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms) <!-- GETTING STARTED -->
## Getting Started

To get a local copy of the project and run the queries, follow these steps.

### Prerequisites

Ensure you have the following installed:
* Microsoft SQL Server (MSSQL).
* AdventureWorks sample database.
* SQL Server Management Studio (SSMS) for querying.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/KosyEzenwaji/AdventureWorks-SQL-Queries.git
   ```
2. Restore the AdventureWorks database:
   [Instructions for AdventureWorks database installation](https://docs.microsoft.com/en-us/sql/samples/adventureworks)

<!-- USAGE EXAMPLES -->
## Usage

The repository contains SQL queries to address various business questions. Below are some examples: 
1. **Filter Products by Colour and Price**:
   - Retrieves products with specific colors and list price between £75 and £750. The `StandardCost` column is renamed to `Price`.
   ```sql
   select Color, Name, StandardCost as Price, ListPrice from Production.Product
   where Color is not null and Color not in ('Red', 'Siver/Black', 'White') and ListPrice between 75 and 750;
   ```
2. **Employee Data Based on Birth and Hire Date**:
   - Fetches male employees born between 1962 to 1970 and hired after 2001, and female employees born between 1972 to 1975 and hired between 2001 and 2002.
     ```sql
     select BusinessEntityID, Gender, Year(BirthDate), year(HireDate) from HumanResources.Employee
     where ((Gender = 'F') and (Year(BirthDate) between 1972 and 1975) and (Year(HireDate) in (2001,2002))
     or ((Gender = 'M') and (Year(BirthDate) between 1962 and 1970) and (Year(HireDate) > 2001)));
     ```

## Contributing

The open-source community is an incredible place to learn, be inspired, and develop because of contributions. Any contributions you make to this SQL project will be much appreciated.

### How to Contribute:

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/NewFeature`).
3. Commit your changes (`git commit -m 'Add NewFeature'`).
4. Push to the branch (`git push origin feature/NewFeature`).
5. Open a pull request for review.

### Reporting Issues:
If you encounter any issues with the queries or have suggestions for improvement, please feel free to open an issue with a detailed description of the problem.

     <!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Kosy Ezenwaji - [kosy.nneoma@gmail.com](mailto:kosy.nneoma@gmail.com)  
GitHub: [https://github.com/KosyEzenwaji](https://github.com/KosyEzenwaji)

Project Link: [https://github.com/KosyEzenwaji/AdventureWorks-SQL-Queries](https://github.com/KosyEzenwaji/AdventureWorks-SQL-Queries)
