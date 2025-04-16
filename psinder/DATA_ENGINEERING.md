# Data Engineering Aspects of Psinder

This document highlights the Data Engineering aspects of the Psinder project, including database schema design, integrity constraints, ETL processes, and analytics capabilities.

## Database Schema & Integrity Constraints

The Psinder database implements a robust schema with carefully designed integrity constraints to prevent logical inconsistencies and maintain data quality.

### Key Integrity Constraints

The following integrity constraints address potential logical loops in the database:

#### User Management Constraints

- **IC1: Self-Block Prevention** - Prevents a user from blocking themselves
- **IC2: Self-Rating Prevention** - Prevents a user from rating their own profile

#### Pet Profile & Interaction Constraints

- **IC8: Self-Like Prevention** - Prevents a pet profile from liking itself
- **IC9: Match ID Ordering** - Ensures consistent ordering of profile IDs in matches (profile_id_1 < profile_id_2)
- **IC10: Verified Match Creation** - Creates matches only upon verified mutual likes
- **IC11: Duplicate Match Prevention** - Prevents duplicate match records with different ordering

#### Conversation & Messaging Constraints

- **IC5: Match-Conversation Consistency** - Ensures conversations only exist for matched profiles
- **IC6: Conversation Member Integrity** - Ensures all matched profiles are added to conversations
- **IC7: Conversation Structure** - Enforces the two-participant structure of conversations

#### Preference & Breeding Constraints

- **IC14: Species Consistency** - Ensures preference matching within the same animal type
- **IC15: Breed Preference Simplification** - Streamlines breed preferences
- **IC16: Fair Matching** - Maintains fairness in matches for pets without breed preferences

### Schema Loops and Their Resolutions

The database contains several potential loops that are addressed by the constraints above:

1. **User_account - User_block - User_account Loop**
   - Potential issue: A user could block themselves
   - Resolution: IC1 prevents self-blocking

2. **User_account - User_grade - User_account Loop**
   - Potential issue: A user could rate themselves
   - Resolution: IC2 prevents self-rating

3. **Pet_profile - Pet_like - Pet_profile Loop**
   - Potential issue: A profile could like itself
   - Resolution: IC8 prevents self-likes

4. **Pet_profile - Pet_match - Pet_profile Loop**
   - Potential issues: Role confusion, duplicate matches
   - Resolution: IC9, IC10, IC11 ensure consistent match representation

5. **Pet_profile - Conversation - Message - Pet_profile Loop**
   - Potential issues: Inconsistent conversation membership, complex multi-participant situations
   - Resolution: IC5, IC6, IC7 enforce logical conversation structure

6. **Pet_profile - Animal_type - Breed - Pet_profile Loop**
   - Potential issues: Cross-species preferences, overly restrictive breed matching
   - Resolution: IC14, IC15, IC16 ensure logical preference matching

## ETL Pipeline

The project includes a sophisticated ETL (Extract, Transform, Load) process in `etl.sql` that:

1. **Extracts** raw data from multiple tables in the database
2. **Transforms** the data by:
   - Calculating metrics like match rates and engagement statistics
   - Cleaning and standardizing values
   - Computing derived fields (like ages from birth dates)
   - Creating aggregations (counts of likes, matches, etc.)
3. **Loads** the transformed data into a denormalized format suitable for analytics

This ETL query can be scheduled to run periodically to update an analytics database or data warehouse.

## Analytics Capabilities

The Psinder database supports advanced analytics through:

1. **Feature Extraction**
   - The `recommendation_features.sql` query extracts rich features for ML models
   - Profile-level attributes (breed, age, location, etc.)
   - Interaction patterns (likes received/sent, match success rate)
   - Engagement metrics (message frequency, conversation engagement)

2. **Key Analytics Metrics**
   - User engagement scoring and activity tracking
   - Match success rates and conversion funnel analysis
   - Geographic distribution and breed popularity
   - Price and purebred percentage market analysis

## Data Quality and Integrity

The project implements comprehensive measures to ensure data quality:

- Primary and foreign key constraints
- Not null constraints on critical fields
- Default values where appropriate
- Consistent use of data types
- Triggers for automated data consistency

## Triggers and Automation

The project uses database triggers to maintain business logic:

- Automatic match creation when two users like each other
- Automatic conversation creation when a match is formed
- Enforcement of integrity constraints during data modifications

## Future Data Engineering Enhancements

Potential enhancements to the data architecture:

1. **Data Partitioning** - Strategy for partitioning large tables like messages
2. **Data Archiving** - Approach for archiving old/inactive data
3. **Materialized Views** - For frequently accessed analytics queries
4. **Advanced Indexing** - Multi-column and partial indexes for complex queries
5. **Timeseries Analysis** - Tracking user engagement metrics over time

## Data Modeling

The database demonstrates solid data modeling principles:

- **Normalized Schema**: The core tables follow normalization principles to reduce redundancy
- **Junction Tables**: Many-to-many relationships are properly modeled with junction tables
- **Indexing Strategy**: Appropriate indexes are created to optimize query performance
- **Constraints**: Foreign key constraints ensure data integrity

## Analytics-Ready Design

The schema is designed with analytics in mind:

- Timestamps on key events (profile creation, likes, matches, messages)
- User activity tracking
- Dimensional data (location, demographics, pet types/breeds)

## Potential Extensions for ML/AI Engineering

To further demonstrate ML/AI Engineering capabilities, consider adding:

1. **Recommendation Engine**: SQL queries that could power a pet recommendation system
2. **Feature Engineering**: Queries that extract features for ML models
3. **A/B Testing**: Database design to support A/B testing of matching algorithms
4. **ML Model Integration**: Examples of how ML model results could be stored and used

## Further Data Engineering Improvements

Potential improvements to showcase more advanced data engineering skills:

1. **Data Partitioning**: Strategy for partitioning large tables like messages
2. **Data Archiving**: Approach for archiving old/inactive data
3. **Materialized Views**: For frequently accessed analytics queries
4. **Data Pipeline**: Scripts to automate the ETL process using tools like Airflow 