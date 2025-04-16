# Psinder - Pet Dating App Database

Psinder is an innovative platform for pet owners that allows users to create profiles for their pets, search for suitable partners for breeding or companionship, and interact with other animal enthusiasts.

## Platform Overview

The Psinder platform enables:
- Creating detailed pet profiles with photos and specifications
- Finding suitable matches based on comprehensive preferences
- Secure messaging between matched pet owners
- Rating system and community moderation
- Search optimization for breeding or companionship

## Database Structure

The database consists of several interconnected tables that handle various aspects of the application:

- **User Management**: `user_account`, `phone_code`, `gender`, `language`, `user_language`, `user_block`, `user_grade`
- **Pet Profiles**: `pet_profile`, `animal_type`, `breed`, `photo_data`
- **Location Data**: `country`, `city`
- **Matching System**: `pet_like`, `pet_match`, `pet_preference`, `country_preference`, `city_preference`, `breed_preference`
- **Messaging**: `conversation`, `conversation_member`, `message`

## Key Features

### User & Pet Profile System

- Users register with unique identifiers (nickname, email, phone)
- Secure authentication with password hashing
- Multiple pet profiles per user account
- Detailed pet information including breed, age, purebred percentage, certifications, and price

### Advanced Matching System

- Smart preference-based matching algorithm 
- Like and match mechanics for connecting compatible pets
- Automatic conversation creation when matches are established
- System enforces logical constraints (e.g., preventing self-likes)

### Preference System

Users can set granular preferences for potential matches:
- Age ranges
- Price ranges (for breeding or adoption)
- Purebred percentage
- Location preferences (cities and countries)
- Breed specifications

### Messaging & Social Features

- Private conversations between matched pet owners
- Blocking capability for community moderation
- Rating system to maintain quality interactions
- Multi-language support for international users

### Data Analytics & ML

- Rich feature extraction for recommendation engine
- Engagement metrics and popularity scoring
- Geographic and demographic analysis
- Breed popularity and preference tracking

## Technical Documentation

For more detailed information, please refer to:

- [Data Engineering Documentation](./DATA_ENGINEERING.md) - Detailed schema information, integrity constraints, and data flow
- [Machine Learning Applications](./ML_APPLICATIONS.md) - Recommendation system architecture and feature engineering
- [Testing Framework](./tests/README.md) - Test development guidelines and existing test cases

## Getting Started

1. Clone the repository
2. Create a PostgreSQL database
3. Run `create.sql` to create the schema
4. (Optional) Run `insert.sql` to populate with sample data
5. Copy `credentials.example.txt` to `credentials.txt` and update with your database connection details
6. Use the Jupyter notebooks in the `queries` directory to explore the data

## Entity Relationship Diagram

[ERD will be added here] 