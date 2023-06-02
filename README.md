<a name="readme-top"></a>

<!--

Hello, it's Angel, if you ever like to use this Readme file as a template let me suggest son required sections, feel free to remove the ones that are not listed if you want.

REQUIRED SECTIONS:
- Table of Contents
- About the Project
  - Built With
  - Live Demo
- Getting Started
- Authors
- Future Features
- Contributing
- Show your support
- Acknowledgements
- License

OPTIONAL SECTIONS:
- FAQ

-->

<!-- <div align="center">
<!-- Angel logo section -->
<!-- </div> -->

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
- [👥 Authors](#authors)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 PP Ecommerce API <a name="about-project"></a>

# ERD(Entity Relationship Diagram)
![image](https://github.com/angeluray/puntospoint-ecommerce/assets/97189760/7397c7dd-e634-4bdc-983a-98b066c84c63)
> API Developed for interviewing purposes.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails 7</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL 15</a></li>
  </ul>
</details>

<!-- Features -->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need at least the following versions of:

`Ruby 2.7.0, 3.x, 4.x 5.x 6`
`Ruby on Rails 7.x`
`PostgreSQL ^12`

### Setup

Clone this repository to your desired folder:


Example commands:

```sh
  cd my-folder
  git clone git@github.com:angeluray/puntospoint-ecommerce.git
```

### Install

Install this project with:

````sh
bundle install
````
> After setting your `username` and `password` in the required fields within the database.yml run the following series of commands:

````sh
  rails db:create
````

````sh
  rails db:migrate
````

````sh
  rails db:seed
````
>  You should be good to go, now you can start the server by running:

````sh
  rails s
````
_Note 1:_ _The port by default is 3001 so that if the API is ever used from a client server the port 3000 will be free for it in Development._


_Note 2:_ _This API is partially working features such as the creation of objects such as Admin, Customer, Sales, Products, and Categories, email sent to owner of product after sale(customer purchase), and logic within the controllers is done.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

- GitHub: [@angeluray](https://github.com/angeluray)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/angeluray-jobs/)


## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
