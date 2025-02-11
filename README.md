Fintech Transaction Data Dashboard
Overview

This project is a cloud-first fintech data analytics platform designed to process and analyze financial transaction data. The goal is to create an efficient system for fraud detection and financial insights, leveraging modern cloud technologies, automation, and containerization.
Features

    Data Processing: Ingest and preprocess Kaggle's fraud detection dataset.
    Cloud Infrastructure: Infrastructure as code using Terraform on Google Cloud Platform (GCP).
    Storage: Use of Google Cloud Storage for raw and processed data.
    Databases: Integration with PostgreSQL for structured data management.
    API Development: Build and expose APIs using Flask for data visualization.
    Containerization: Use Docker for packaging and deployment.
    Automation: CI/CD pipelines for deployment and testing.
    Optional Enhancements: BigQuery for advanced analytics, user authentication, and frontend dashboard.

Tech Stack

    Programming Language: Python
    Cloud Provider: Google Cloud Platform (GCP)
    Infrastructure: Terraform
    Database: PostgreSQL
    Tools: Docker, pgAdmin, Jupyter Notebooks, GitHub Codespaces
    Others: GitHub Copilot, VSCode

Setup
Prerequisites

Make sure the following tools are installed on your system:

    Docker: For containerization and deployment.
    Terraform: For managing infrastructure as code.
    Google Cloud CLI: For managing Google Cloud resources.
    VSCode: The preferred code editor for development.
    Git: For version control.

Configure your Google Cloud account and project before starting the setup.
Steps to Set Up

    Clone this repository:

git clone <repository-url>
cd <repository-folder>

Set up Google Cloud infrastructure:

Navigate to the terraform directory:

cd terraform

Initialize Terraform:

terraform init

Apply the configurations to set up the infrastructure:

terraform apply

Launch Docker containers:

Run the following command to start the required Docker containers:

docker-compose up

Run the Flask application:

Navigate to the api directory:

    cd api
    python app.py

    Test and Explore:

    Access the APIs or dashboards exposed on your configured ports.

Project Goals

    Learn cloud infrastructure with Terraform and GCP.
    Practice data engineering techniques such as ETL pipelines, storage management, and database integration.
    Build a robust portfolio project demonstrating real-world data engineering skills.

Future Enhancements

    BigQuery Integration: For faster querying and scalable analytics.
    Authentication System: To secure APIs and data access.
    Frontend Dashboard: Interactive visualizations for better user experience.


