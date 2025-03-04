# ruby-compiler-with-nextjs
This project is a full-stack web application with a **Ruby on Rails** backend and a **Next.js** frontend. the main agenda is code **compile**. currently it's support **php, ruby, javascript, python**.it's a practice project 

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Backend Setup (Ruby on Rails)](#backend-setup-ruby-on-rails)
- [Frontend Setup (Next.js)](#frontend-setup-nextjs)
- [Running the Application](#running-the-application)
- [Environment Variables](#environment-variables)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)
  
``` bash
project-root/  
├── backend/ # Ruby on Rails backend  
│ ├── app/  
│ ├── config/  
│ ├── db/  
│ ├── ...  
├── frontend/ # Next.js frontend  
│ ├── pages/  
│ ├── public/  
│ ├── styles/  
│ ├── ...

```  

## Prerequisites

Before you begin, ensure you have the following installed:

- **Ruby** (version 3.1.3)
- **Rails** (version 7.2.2.1)
- **Node.js** (version v20.9.0 or upper)
- **npm**
- **Mysql**(not mendatory)

## Backend Setup (Ruby on Rails)

1. Navigate to the `backend` directory:
   ```bash
   cd backend
2. Install Ruby dependencies:
   ``` bash
   bundle install
3. Set up the database(optional that case no need):
   ``` bash
   rails db:create
   rails db:migrate
4. Start the Rails server:
   ``` bash
   rails server or rails server -p <port>

## Frontend Setup (Next.js)  

1. Navigate to the frontend directory:
   ``` bash
   cd frontend
2. Install Node.js dependencies:
   ``` bash
   npm install
2. Start the Next.js development server:
   ``` bash
   npm run dev


The frontend will be running at http://localhost:4000 or update package.json

## Environment Variables

# Backend (Rails)  

Create a `.env` file in the backend directory with the following variables:  

# Frontend (Next.js)  

Create a `.env.local` file in the frontend directory with the following variables:  

``` NEXT_PUBLIC_API_URL=http://localhost:3000 or NEXT_PUBLIC_API_URL=http://localhost:<api build port> ``` 


# Deployment

## Backend Deployment

Deploy the Rails app to your preferred platform (e.g., Heroku, AWS, etc.).

## Frontend Deployment

Deploy the Next.js app to Vercel or another hosting service.
  
