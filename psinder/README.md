# Psinder - Pet Dating App Database

Psinder is a PostgreSQL database for a pet dating application (like Tinder, but for pets). The database is designed to support all the core functionality of a modern dating app, including user accounts, pet profiles, matching system, messaging, and preferences.

## Database Overview

The database consists of several interconnected tables that handle various aspects of the application:

- **User Management**: `user_account`, `phone_code`, `gender`, `language`, `user_language`, `user_block`, `user_grade`
- **Pet Profiles**: `pet_profile`, `animal_type`, `breed`, `photo_data`
- **Location Data**: `country`, `city`
- **Matching System**: `pet_like`, `pet_match`, `pet_preference`, `country_preference`, `city_preference`
- **Messaging**: `conversation`, `conversation_member`, `message`

## Key Features

### Profile & Matching System

The system allows users to create profiles for their pets and find matches:
- Pets can have multiple photos, description, breed info
- Users can like other pet profiles
- When two users like each other, a match is created automatically via a trigger
- When a match is created, a conversation is automatically started

### Preference System

Users can set preferences for potential matches:
- Age ranges
- Price ranges (for breeding or adoption)
- Purebred percentage
- Location preferences (cities and countries)

### Messaging System

When two pets match, a conversation is created automatically:
- Multiple pets can participate in a conversation
- Messages are stored with timestamps
- Users can see conversation history

### Data Analytics

The database has an ETL query (`etl.sql`) for extracting analytics data:
- Match rates
- User engagement metrics
- Geographic distribution
- Breed popularity

## Schema Highlights

### Triggers

The system has two main triggers:
1. `pet_match_trigger` - Creates a match when two pets like each other
2. `create_conversation_trigger` - Creates a conversation when a match is made

### Indexes

Several indexes are created to optimize common queries:
- Indexes for fast mutual like lookups
- Indexes on foreign keys for efficient joins

## Example Queries

The `queries` directory contains example queries for common operations:
- Finding potential matches based on preferences
- Analytics on user behavior
- Geographic distribution of users
- Most popular breeds

## Getting Started

1. Clone the repository
2. Create a PostgreSQL database
3. Run `create.sql` to create the schema
4. (Optional) Run `insert.sql` to populate with sample data
5. Copy `credentials.example.txt` to `credentials.txt` and update with your database connection details
6. Use the Jupyter notebook in the `queries` directory to explore the data

## Entity Relationship Diagram

[ERD will be added here] 